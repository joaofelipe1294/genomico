class IndicatorsController < ApplicationController
  include ResponseTimeReport

  def exams_per_field
  end

  def exams_in_progress
    exams = Exam
                .joins(:offered_exam)
                .where.not(exam_status_kind: ExamStatusKind.COMPLETE)
                .where.not(exam_status_kind: ExamStatusKind.CANCELED)
    @exams_in_progress_count = exams.size
    @exams_relation = generate_fields_relation exams
  end

  def concluded_exams
    complete_exams = Exam.joins(:offered_exam).where(exam_status_kind: ExamStatusKind.COMPLETE)
    complete_exams = filter_by_date complete_exams
    @concluded_exams_cont = complete_exams.size
    @complete_exams_relation = generate_fields_relation complete_exams
  end

  def health_ensurances_relation
    exams = Exam.complete.joins(:attendance)
    exams = exams.where("exams.finish_date BETWEEN ? AND ?", params[:start_date], params[:end_date]) if filter_by_date
    @concluded_exams_cont = exams.size
    @exams_relation = exams.joins(attendance: [:health_ensurance]).complete.group("health_ensurances.name").count
  end

  private

  def filter_by_date exams
    start_date = params[:start_date]
    end_date = params[:end_date]
    if start_date.present? && end_date.present?
      exams = exams.where("exams.finish_date BETWEEN ? AND ?", start_date, end_date)
    end
    exams
  end

  def generate_fields_relation exams
    exams_relation = {}
    Field.all.order(:name).each do |field|
      amount = exams.where("offered_exams.field_id = ?", field.id).size
      exams_relation[field.name] = amount if amount > 0
    end
    exams_relation
  end

  def filter_by_date
    params[:start_date].present? && params[:end_date].present?
  end

end
