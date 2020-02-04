require './app/reports/exam_report'

class GlobalProductionReport
  include ExamReport

  def initialize params: {}
    @exams = Exam.joins(offered_exam: [:field]).not_canceled
    if params[:start_date].present? && params[:finish_date].present?
      @start_date = params[:start_date]
      @finish_date = params[:finish_date]
      @exams = filter_by_date @exams
    end
  end

  def field_relation
    relation = @exams.group("fields.name").count
    relation["Citogenética"] = relation.delete "FISH" if relation.key? "FISH"
    relation
  end

end
