module AttendancesHelper
  include AttendanceStatusKinds

  def check_attendance_status attendance
    @attendance = attendance
    if @attendance.attendance_status_kind == AttendanceStatusKinds::COMPLETE
      flash[:info] = "Atendimento encerrado em #{I18n.l @attendance.finish_date.to_date}."
    elsif all_exams_are_complete?
        if @attendance.conclude
          flash[:success] = I18n.t :complete_attendance_success
        else
          flash[:error] = I18n.t :server_error_message
        end
    elsif has_pendent_reports?
      flash[:info] = I18n.t :pending_reports_message
    end
  end

  private

    def all_exams_are_complete?
      exams = @attendance.exams
      complete_and_canceled_exams = exams.
                                          where(exam_status_kind: ExamStatusKinds::COMPLETE).
                                          or(
                                            exams.where(exam_status_kind: ExamStatusKinds::CANCELED)
                                          ).size
      exams.size == complete_and_canceled_exams
    end

    def has_pendent_reports?
      reports_without_report = @attendance.
                                          exams.
                                          where(
                                            exam_status_kind: ExamStatusKinds::COMPLETE_WITHOUT_REPORT
                                          ).size
      reports_without_report > 0
    end

end









































# def check_attendance_status
#   complete_exams = @attendance.exams.where(exam_status_kind: ExamStatusKind::COMPLETE).size
#   complete_without_report_exams = @attendance.exams.where(exam_status_kind: ExamStatusKinds::COMPLETE_WITHOUT_REPORT).size
#   complete_exams = complete_exams + complete_without_report_exams
#   if @attendance.attendance_status_kind == AttendanceStatusKinds::COMPLETE
#     flash[:info] = "Atendimento encerrado em #{I18n.l @attendance.finish_date.to_date}."
#   elsif complete_exams == @attendance.exams.size
#     all_exams_has_report = true
#     @attendance.exams.each do |exam|
#       all_exams_has_report = false if exam.report? == false
#     end
#     if all_exams_has_report
#       new_params = {
#         attendance_status_kind: AttendanceStatusKind::COMPLETE,
#         finish_date: Date.today,
#       }
#       if @attendance.update new_params
#         flash[:success] = I18n.t :complete_attendance_success
#       else
#         flash[:error] = I18n.t :server_error_message
#       end
#     else
#       flash[:info] = I18n.t :pending_reports_message
#     end
#   end
# end
