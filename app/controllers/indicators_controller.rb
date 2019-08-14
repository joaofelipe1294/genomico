class IndicatorsController < ApplicationController
  def exams_per_field
  end

  def exams_in_progress
    @exams_in_progress_count = Exam.where.not(exam_status_kind: ExamStatusKind.find_by({name: 'Concluído'})).size
  end

  def concluded_exams
    # Exam.where('created_at BETWEEN ? AND ?', @selected_date.beginning_of_day, @selected_date.end_of_day)
    @concluded_exams_cont = Exam.where(exam_status_kind: ExamStatusKind.find_by({name: 'Concluído'})).size
  end

end
