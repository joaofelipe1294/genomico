module ExamsHelper

  def exam_options_helper exam
    options = ""
    if exam.exam_status_kind == ExamStatusKind.WAITING_START
      options << link_to('Iniciar exame', start_exam_path(exam), id: 'start-exam', class: 'btn btn-sm btn-outline-primary ml-3 start-exam')
    elsif exam.exam_status_kind != ExamStatusKind.COMPLETE_WITHOUT_REPORT && exam.exam_status_kind != ExamStatusKind.COMPLETE
      options << link(exam, new_status: ExamStatusKind.TECNICAL_RELEASED, css_class: 'info change-to-tecnical-released') unless exam.exam_status_kind == ExamStatusKind.TECNICAL_RELEASED
      options << link(exam, new_status: ExamStatusKind.IN_REPEAT, css_class: 'secondary change-to-in-repeat') unless exam.exam_status_kind == ExamStatusKind.IN_REPEAT
      options << link_to('Liberado parcial', change_to_partial_released_path(exam), class: 'btn btn-sm btn-outline-dark ml-3 change-to-partial-released')
      unless exam.exam_status_kind == ExamStatusKind.COMPLETE || exam.exam_status_kind == ExamStatusKind.COMPLETE_WITHOUT_REPORT
        options << link_to('Concluído', change_to_completed_path(exam), data: { confirm: "Tem certeza ?" }, method: :patch, class: 'btn btn-sm btn-outline-success ml-3 change-to-complete')
      end
    elsif exam.exam_status_kind == ExamStatusKind.COMPLETE_WITHOUT_REPORT
        options << link_to('Adicionar laudo', add_report_to_exam_path(exam), class: 'ml-3 add-report')
    else
      options << "<label class = 'text-success ml-3'>Exame concluído</label>".html_safe
      options << link_to('Visualizar laudo', add_report_to_exam_path(exam), class: 'btn btn-sm btn-outline-info see-report ml-3')
    end
    options << link_to('Editar', edit_exam_path(exam), class: 'btn btn-sm btn-outline-warning ml-2 edit-exam')
    options.html_safe
  end

  def link(exam, new_status: nil, css_class: "", method: "patch")
    link_to(
      new_status.name,
      change_exam_status_path(exam, {new_status: new_status}),
      method: method,
      class: "btn btn-sm ml-3 btn-outline-#{css_class}"
    )
  end

end
