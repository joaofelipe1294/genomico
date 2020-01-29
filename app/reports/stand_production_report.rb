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
      exams_from_field = Exam.from_field @field
      if @start_date && @finish_date
        exams_from_field = exams_from_field.where("exams.created_at BETWEEN ? AND ?", @start_date, @finish_date)
      end
      exams_from_field
    end

end
