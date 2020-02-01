module AttendancesHelper

  def show_attendance_finish_date attendance
    finish_date = attendance.finish_date
    unless finish_date
      return "-"
    else
      return I18n.l finish_date.to_date
    end
  end

end
