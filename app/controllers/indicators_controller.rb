class IndicatorsController < ApplicationController
  before_action :user_filter
  before_action :set_exams, only: [:concluded_exams, :health_ensurances_relation]

  def exams_in_progress
    @exams = Exam.joins(offered_exam: [:field]).where.not(status: [:canceled, :complete])
    @relation = @exams.group("fields.name").count
  end

  def concluded_exams
    @relation = @exams.joins(offered_exam: [:field]).group("fields.name").count
  end

  def health_ensurances_relation
    @relation = @exams.joins(attendance: [:health_ensurance]).where.not(status: :canceled).group("health_ensurances.name").count
  end

  def response_time
    @report = ResponseTimeReport.new({group: params[:group], start_date: params[:start_date], finish_date: params[:end_date]})
  end

  def production_per_stand
    @report = StandProductionReport.new({stand: params[:stand], start_date: params[:start_date], finish_date: params[:end_date]})
  end

  def global_production
  end

  private

    def set_exams
      @exams = Exam.where.not(status: :canceled).joins(offered_exam: [:field])
      if params[:start_date].present? && params[:end_date].present?
        @exams = @exams.where("exams.created_at BETWEEN ? AND ?", params[:start_date], params[:end_date])
      end
    end

end
