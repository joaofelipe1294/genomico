class ResponseTimeReport

  def initialize params
    @offered_exam_group = params[:offered_exam_group]
    @start_date = params[:start_date]
    @end_date = params[:finish_date]
    @exams = exams
  end

  def exams_count
    @exams.size
  end

  def patient_count
    @exams.pluck(:patient_id).uniq.size
  end

  def complete_with_delay
    @exams.where(was_late: true).size
  end

  def complete_in_time
    @exams.where(was_late: false).size
  end

  def complete_with_delay_relation
    @exams.where(was_late: true).group("offered_exams.mnemonyc").count
  end

  def complete_in_time_relation
    @exams.where(was_late: false).group("offered_exams.mnemonyc").count
  end

  def chart
    {
      "Em tempo": complete_in_time(),
      "Atrasados": complete_with_delay()
    }
  end

  def exams_relation
    [
      { name: "Em tempo", data: complete_in_time_relation },
      { name: "Com atraso", data: complete_with_delay_relation }
    ]
  end

  def statistics
    exam_info = []
    offered_exams = OfferedExam.where(offered_exam_group: @offered_exam_group)
    offered_exams.each do |offered_exam|
      exam_group = @exams.where(offered_exam: offered_exam)
      unless exam_group.empty?
        exam_info << ExamGroupStatisticsService.new(exam_group).call
      end
    end
    exam_info
  end

  private

    def exams
      exams_found = Exam
                        .joins(:attendance, offered_exam: [:offered_exam_group])
                        .where(exam_status_kind: ExamStatusKind.COMPLETE)
                        .where("offered_exams.offered_exam_group_id = ? ", @offered_exam_group)
      if @start_date && @finish_date
        exams_found = exams_found.where("exams.created_at BETWEEN ? AND ?", @start_date, @finish_date)
      end
      exams_found
    end

end
