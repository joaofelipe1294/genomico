class CorrectDelayedExams < ActiveRecord::Migration[5.2]
  def change
    ExamStatusKinds
    Exam.where.not(exam_status_kind: ExamStatusKind.CANCELED).where.not(attendance: nil).each do |exam|
      puts "=============================================="
      p exam
      refference_date = exam.offered_exam.refference_date
      if exam.exam_status_kind == ExamStatusKind.COMPLETE
        puts "COMPLETO"
        business_days_since_creation = (exam.created_at.to_date..exam.finish_date).select { |d| (1..5).include?(d.wday) }.size
      else
        puts "EM ANDAMENTO"
        business_days_since_creation = (exam.created_at.to_date..Date.current).select { |d| (1..5).include?(d.wday) }.size
      end
      if business_days_since_creation > refference_date
        exam.was_late = true
        exam.lag_time = business_days_since_creation - refference_date
        puts "ATRADOU #{(business_days_since_creation - refference_date)} DIAS"
      else
        puts "NAO ATRASOU"
        exam.was_late = false
      end
      exam.save
      puts "=============================================="
    end
  end
end
