module ExamsHelper

  def exam_options_helper exam
    options = ""
    if exam.exam_status_kind == ExamStatusKind.WAITING_START
      options << link_to('Iniciar exame', start_exam_path(exam), id: 'start-exam', class: 'btn btn-sm btn-outline-primary ml-3 start-exam')
    elsif exam.exam_status_kind != ExamStatusKind.COMPLETE
      unless exam.exam_status_kind == ExamStatusKind.TECNICAL_RELEASED
        options << link_to('Liberado técnico', change_to_tecnical_released_path(exam), method: :patch, class: 'btn btn-sm btn-outline-info ml-3 change-to-tecnical-released')
      end
      unless exam.exam_status_kind == ExamStatusKind.IN_REPEAT
        options << link_to('Em repetição', change_to_in_repeat_path(exam), method: :patch, class: 'btn btn-sm btn-outline-secondary ml-3 change-to-in-repeat')
      end
      unless exam.exam_status_kind == ExamStatusKind.COMPLETE
        options << link_to('Concluído', change_to_completed_path(exam), data: { confirm: "Tem certeza ?" }, method: :patch, class: 'btn btn-sm btn-outline-success ml-3 change-to-complete')
      end
    else
      options << "<label class = 'text-success'>Exame concluído</label>".html_safe
      unless exam.report?
        options << link_to('Adicionar laudo', add_report_to_exam_path(exam), class: 'btn btn-sm btn-outline-secondary add-report')
      else
        options << "LAUDO XXX"
      end
    end
    options << link_to('Editar', edit_exam_path(exam), class: 'btn btn-sm btn-outline-warning ml-2 edit-exam')
    options.html_safe
  end

  def exam_status_helper exam_status_kind
    text_style = ""
    if exam_status_kind == ExamStatusKind.IN_PROGRESS
      text_style = "text-primary"
    elsif exam_status_kind == ExamStatusKind.COMPLETE
      text_style = "text-success"
    elsif exam_status_kind == ExamStatusKind.IN_REPEAT
      text_style = "text-secondary"
    elsif exam_status_kind == ExamStatusKind.TECNICAL_RELEASED
      text_style = "text-info"
    end
    "<label class='#{text_style}'>#{exam_status_kind.name}</label>".html_safe
  end

end
