class IndicatorsController < ApplicationController
  before_action :user_filter
  before_action :set_exams, only: [:concluded_exams, :health_ensurances_relation]

  def exams_in_progress
    @exams = Exam.joins(offered_exam: [:field]).where.not(status: [:canceled, :complete])
    @relation = @exams.group("fields.name").count
  end

  def concluded_exams
    @exams = @exams.where("exams.finish_date BETWEEN ? AND ?", params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
    @relation = @exams.complete.group("fields.name").count
  end

  def health_ensurances_relation
    @exams = @exams.where("exams.created_at BETWEEN ? AND ?", params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
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
      @exams = Exam.joins(offered_exam: [:field]).where.not(status: :canceled)
    end

    # def filter_by_created_at
    #   # @exams = Exam.joins(offered_exam: [:field]).where.not(status: :canceled)
    #   if params[:start_date].present? && params[:end_date].present?
    #     @exams = @exams.where("exams.created_at BETWEEN ? AND ?", params[:start_date], params[:end_date])
    #   end
    # end
    #
    # def filter_by_finsh_date
    #   # @exams = Exam.joins(offered_exam: [:field]).where.not(status: :canceled)
    #   if params[:start_date].present? && params[:end_date].present?
    #     @exams = @exams.where("exams.created_at BETWEEN ? AND ?", params[:start_date], params[:end_date])
    #   end
    # end

end
