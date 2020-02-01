module AttendancesHelper

  def show_attendance_status attendance
    if attendance.progress?
      color = :secondary
    else
      color = :success
    end
    %Q(<span class="text-#{color}">#{attendance.status_name}</span>).html_safe
  end

  def show_attendance_finish_date attendance
    if attendance.finish_date.nil?
      return "-"
    else
      return I18n.l attendance.finish_date.to_date
    end
  end

end
