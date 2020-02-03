require './app/reports/exam_report'

class ResponseTimeReport
  include ExamReport

  def initialize params
    @offered_exam_group = params[:group]
    @start_date = params[:start_date]
    @end_date = params[:finish_date]
    @exams = filter_by_date exams
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
      "Em tempo": complete_in_time,
      "Atrasados": complete_with_delay
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
    offered_exams = OfferedExam.where(group: @offered_exam_group)
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
      Exam
          .joins(:attendance, :offered_exam)
          .complete
          .where("offered_exams.group = ? ", OfferedExam.groups[@offered_exam_group].to_i)
    end

end
