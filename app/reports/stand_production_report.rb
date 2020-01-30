class StandProductionReport

  def initialize params
    @start_date = params[:start_date]
    @finish_date = params[:finish_date]
    @exams = filter_by_date params[:exams]
  end

  def exam_count
    @exams.size
  end

  def exam_relation_menmonyc
    @exams.order("offered_exams.mnemonyc").group("offered_exams.mnemonyc").count
  end

  def exam_relation
    @exams.order("offered_exams.name").group("offered_exams.name").count
  end

  def attendance_count
    @exams.pluck(:attendance_id).uniq.size
  end

  def patient_count
    @exams.includes(:attendance).pluck(:patient_id).uniq.size
  end

  private

    def filter_by_date exams
      if @start_date && @finish_date
        exams = exams.where("exams.created_at BETWEEN ? AND ?", @start_date, @finish_date)
      end
      exams
    end

end
