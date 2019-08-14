class IndicatorsController < ApplicationController
  def exams_per_field
  end

  def exams_in_progress
    @exams_in_progress_count = Exam.where.not(exam_status_kind: ExamStatusKind.find_by({name: 'Concluído'})).size
  end
end
