class IndicatorsController < ApplicationController
  before_action :set_exams, only: [:exams_in_progress, :concluded_exams, :health_ensurances_relation]

  def exams_in_progress
    exams = Exam.joins(offered_exam: [:field]).where.not(exam_status_kind: [ExamStatusKind.CANCELED, ExamStatusKind.COMPLETE])
    @exams_in_progress_count = exams.size
    @exams_relation = exams.group("fields.name").count
  end

  def concluded_exams
    exams = set_exams
    @concluded_exams_cont = exams.size
    @complete_exams_relation = exams.joins(offered_exam: [:field]).group("fields.name").count
  end

  def health_ensurances_relation
    exams = set_exams
    @concluded_exams_cont = exams.size
    @exams_relation = exams.joins(attendance: [:health_ensurance]).complete.group("health_ensurances.name").count
  end

  def response_time
    @offered_exam_group = OfferedExamGroup.find params[:id]
    @report = ResponseTimeReport.new({offered_exam_group: @offered_exam_group, start_date: params[:start_date], finish_date: params[:end_date]})
    @pie_chart = {
      "Em tempo": @report.complete_in_time,
      "Atrasados": @report.complete_with_delay
    }
    @exams_relation = [
      { name: "Em tempo", data: @report.complete_in_time_relation },
      { name: "Com atraso", data: @report.complete_with_delay_relation }
    ]
  end

  def production_per_stand
    stand = params[:stand].to_sym
    if stand == :biomol
      exams = Exam.from_field Field.BIOMOL
    elsif stand == :imunofeno
      exams = Exam.from_field Field.IMUNOFENO
    elsif stand == :cyto
      exams = Exam.from_field Field.FISH
    end
    @report = StandProductionReport.new({exams: exams, start_date: params[:start_date], finish_date: params[:end_date]})
  end

  private

  def set_exams
    start_date = params[:start_date]
    end_date = params[:end_date]
    exams = Exam.complete.joins(offered_exam: [:field])
    exams = exams.where("exams.finish_date BETWEEN ? AND ?", start_date, end_date) if start_date && end_date
    exams
  end

end
