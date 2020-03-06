class RepeatExamsReport

  def initialize params
    @exam_changes = ExamStatusChange.where(new_status: :in_repeat).joins(exam: [:offered_exam])
    @start_date = params[:start_date]
    @finish_date = params[:finish_date]
    @exam_changes = filter_by_date if params[:start_date].present? && params[:finish_date].present?
  end

  def relation
    @exam_changes.group("offered_exams.name").count
  end

  def count
    @exam_changes.count
  end

  def filter_by_date
    @exam_changes.where("change_date BETWEEN ? AND ?", @start_date, @finish_date)
  end

end
