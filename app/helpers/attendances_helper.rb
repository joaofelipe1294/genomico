module AttendancesHelper

  # def close_attendance_helper attendance # disponibilizar na controller !!!
  #   complete_exams = attendance.exams.where(exam_status_kind: ExamStatusKind.COMPLETE).size
  #   if complete_exams == attendance.exams.size
  #     all_exams_has_report = true
  #     attendance.exams.each do |exam|
  #       all_exams_has_report = false if exam.report? == false
  #     end
  #     if all_exams_has_report
  #       new_params = {
  #         attendance_status_kind: AttendanceStatusKind.COMPLETE,
  #         finish_date: Date.today,
  #       }
  #       if attendance.update new_params
  #         flash[:success] = I18n.t :complete_attendance_success
  #         redirect_to home_user_index_path
  #       else
  #         flash[:error] = I18n.t :server_error_message
  #         redirect_to workflow_path(attendance)
  #       end
  #     else
  #       flash[:info] = I18n.t :pending_reports_message
  #       redirect_to workflow_path
  #     end
  #   end
  # end

  # def verify_exam_status
  #   has_finished_all_exams = (@attendance.exams.where.not(exam_status_kind: ExamStatusKind.find_by(name: 'Concluído')).size == 0)
  #   if @attendance.report? && has_finished_all_exams && @attendance.attendance_status_kind != AttendanceStatusKind.find_by({name: 'Concluído'})
  #     # irá encerrar o exame
  #     new_params = {
  #       attendance_status_kind: AttendanceStatusKind.find_by({name: 'Concluído'}),
  #       finish_date: Date.today,
  #     }
  #     if @attendance.update(new_params)
  #       flash[:success] = 'Atendimento encerrado com sucesso.'
  #       redirect_to home_user_index_path
  #     else
  #       flash[:warning] = 'Erro ao encerrar o atendimento.'
  #       redirect_to workflow_path(@attendance)
  #     end
  #   elsif @attendance.report? == false && has_finished_all_exams
  #     # falta o laudo
  #     flash[:info] = 'Adicione o laudo para que o atendimento seja encerrado.'
  #   elsif @attendance.report? && has_finished_all_exams == false
  #     # restam exames
  #     flash[:info] = 'Existem exames aguardando encerramento para que o atendimento seja encerrado.'
  #   elsif @attendance.attendance_status_kind == AttendanceStatusKind.find_by({name: 'Concluído'})
  #     # atendimento já encerrado
  #     flash[:info] = "Atendimento encerrado em #{@attendance.finish_date.strftime("%d/%m/%Y")}."
  #   end
  # end

end
