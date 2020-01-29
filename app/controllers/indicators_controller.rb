class IndicatorsController < ApplicationController
  include ResponseTimeReport
  before_action :set_exams, only: [:exams_in_progress, :concluded_exams, :health_ensurances_relation]

  def exams_per_field
  end

  def exams_in_progress
    exams = Exam.joins(offered_exam: [:field]).where.not(exam_status_kind: [ExamStatusKind.CANCELED, ExamStatusKind.COMPLETE])
    @exams_in_progress_count = exams.size
    @exams_relation = exams.group("fields.name").count
  end

  def concluded_exams
    @concluded_exams_cont = @exams.size
    @complete_exams_relation = @exams.joins(offered_exam: [:field]).group("fields.name").count
  end

  def health_ensurances_relation
    @concluded_exams_cont = @exams.size
    @exams_relation = @exams.joins(attendance: [:health_ensurance]).complete.group("health_ensurances.name").count
  end

  private

  def set_exams
    start_date = params[:start_date]
    end_date = params[:end_date]
    @exams = Exam.complete.joins(offered_exam: [:field])
    @exams = @exams.where("exams.finish_date BETWEEN ? AND ?", start_date, end_date) if start_date && end_date
  end

end


# TODO: Continuar refatorando indicadores atuais ...
