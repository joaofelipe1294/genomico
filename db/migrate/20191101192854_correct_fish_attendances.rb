class CorrectFishAttendances < ActiveRecord::Migration[5.2]
  def change
    ExamStatusKinds
    attendance = Attendance.find 155
    attendance.update({attendance_status_kind: AttendanceStatusKind.IN_PROGRESS, finish_date: nil})
    attendance.exams << Exam.new({offered_exam_id: 64, exam_status_kind: ExamStatusKind.WAITING_START})
    attendance.save

    attendance_2 = Attendance.find 202
    attendance_2.update({attendance_status_kind: AttendanceStatusKind.IN_PROGRESS, finish_date: nil})
    attendance_2.exams << Exam.new({offered_exam_id: 66, exam_status_kind: ExamStatusKind.WAITING_START})
    attendance_2.save
  end
end
