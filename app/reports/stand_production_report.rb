class StandProductionReport

  def initialize params
    @field = params[:field]
    @start_date = params[:start_date]
    @finish_date = params[:finish_date]
  end

  def exams_count
    exams.size
  end

  def exams_relation
    exams.group("offered_exams.name").count
  end

  private

    def exams
      exams = Exam.joins(:offered_exam).where("offered_exams.field_id = ?", @field.id)
      if @start_date && @finish_date
        exams = exams.where("exams.created_at BETWEEN ? AND ?", @start_date, @finish_date)
      end
      exams
    end

end
