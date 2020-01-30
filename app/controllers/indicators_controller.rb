class IndicatorsController < ApplicationController
  before_action :user_filter
  before_action :set_exams, only: [:concluded_exams, :health_ensurances_relation]
  before_action :set_offered_exam_group, only: [:response_time]

  def exams_in_progress
    @exams = Exam.joins(offered_exam: [:field]).where.not(exam_status_kind: [ExamStatusKind.CANCELED, ExamStatusKind.COMPLETE])
    @relation = @exams.group("fields.name").count
  end

  def concluded_exams
    @relation = @exams.joins(offered_exam: [:field]).group("fields.name").count
  end

  def health_ensurances_relation
    @relation = @exams.joins(attendance: [:health_ensurance]).complete.group("health_ensurances.name").count
  end

  def response_time
    @report = ResponseTimeReport.new({offered_exam_group: @offered_exam_group, start_date: params[:start_date], finish_date: params[:end_date]})
  end

  def production_per_stand
    @report = StandProductionReport.new({stand: params[:stand], start_date: params[:start_date], finish_date: params[:end_date]})
  end

  def global_production
  end

  private

    def set_exams
      start_date = params[:start_date]
      end_date = params[:end_date]
      @exams = Exam.complete.joins(offered_exam: [:field])
      @exams = @exams.where("exams.finish_date BETWEEN ? AND ?", start_date, end_date) if start_date && end_date
    end

    def set_offered_exam_group
      @offered_exam_group = OfferedExamGroup.find params[:id]
    end

end
