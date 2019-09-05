module AttendancesHelper

  def exam_options_helper exam
    options = ""
    if exam.exam_status_kind == ExamStatusKind.WAITING_START
      options << link_to('Iniciar exame', start_exam_path(exam), id: 'start-exam', class: 'btn btn-sm btn-outline-primary ml-3 start-exam')
    elsif exam.exam_status_kind != ExamStatusKind.COMPLETE
      unless exam.exam_status_kind == ExamStatusKind.TECNICAL_RELEASED
        options << link_to('Liberado técnico', change_to_tecnical_released_path(exam), method: :patch, class: 'btn btn-sm btn-outline-info ml-3', id: 'chnge-to-tecnical-released')
      end
      unless exam.exam_status_kind == ExamStatusKind.IN_REPEAT
        options << link_to('Em repetição', change_to_in_repeat_path(exam), method: :patch, class: 'btn btn-sm btn-outline-secondary ml-3', id: 'change-to-in-repetition')
      end
      unless exam.exam_status_kind == ExamStatusKind.COMPLETE
        options << link_to('Concluído', change_to_completed_path(exam), data: { confirm: "Tem certeza ?" }, method: :patch, class: 'btn btn-sm btn-outline-success ml-3', id: 'change-exam-to-completed')
      end
    else
      options << "<label class = 'text-success'>Exame concluído</label>".html_safe
    end
    if exam.exam_status_kind != ExamStatusKind.WAITING_START
     options << link_to('Editar', edit_exam_path(exam), class: 'btn btn-sm btn-outline-warning ml-2', id: 'edit-attendance-exam')
    end
    options.html_safe
  end
end
