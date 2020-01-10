module AttendancesHelper

  def check_attendance_status attendance
    @attendance = attendance
    if @attendance.attendance_status_kind == AttendanceStatusKind.COMPLETE
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
                                          where(exam_status_kind: ExamStatusKind.COMPLETE).
                                          or(
                                            exams.where(exam_status_kind: ExamStatusKind.CANCELED)
                                          ).size
      exams.size == complete_and_canceled_exams
    end

    def has_pendent_reports?
      reports_without_report = @attendance.
                                          exams.
                                          where(
                                            exam_status_kind: ExamStatusKind.COMPLETE_WITHOUT_REPORT
                                          ).size
      reports_without_report > 0
    end

end
