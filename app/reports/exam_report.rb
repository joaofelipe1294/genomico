module ExamReport

  def exam_count
    @exams.size
  end

  def patient_count
    @exams.includes(:attendance).pluck(:patient_id).uniq.size
  end

  def filter_by_date exams
    if @start_date && @finish_date
      exams = exams.where("exams.created_at BETWEEN ? AND ?", @start_date, @finish_date)
    end
    exams
  end

end
