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
    complete_exams = Exam.joins(:attendance).where(exam_status_kind: ExamStatusKind.COMPLETE)
    complete_exams = filter_by_date complete_exams
    @concluded_exams_cont = complete_exams.size
    @exams_relation = {}
    HealthEnsurance.all.order(:name).each do |health_ensurance|
      amount_by_health_ensurance = complete_exams.where("attendances.health_ensurance_id = ?", health_ensurance.id).size
      @exams_relation[health_ensurance.name] = amount_by_health_ensurance if amount_by_health_ensurance > 0
    end
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

end
