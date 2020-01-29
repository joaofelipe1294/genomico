class StandProductionReport

  def initialize params
    @field = params[:field]
    @start_date = params[:start_date]
    @finish_date = params[:finish_date]
  end

  def exam_count
    exams_from_field.size
  end

  def exam_relation
    exams_from_field.group("offered_exams.name").count
  end

  def attendance_count
    exams_from_field.pluck(:attendance_id).uniq.size
  end

  def patient_count
    exams_from_field.includes(:attendance).pluck(:patient_id).uniq.size
  end

  private

    def exams_from_field
      exams = Exam.from_field @field
      if @start_date && @finish_date
        exams = exams.where("exams.created_at BETWEEN ? AND ?", @start_date, @finish_date)
      end
      exams
    end

end
