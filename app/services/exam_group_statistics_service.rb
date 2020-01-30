
class ExamGroupStatisticsService

  def initialize exams
    @exams = exams
  end

  def call
    {
      name: @exams.first.offered_exam.show_name,
      reference_time: @exams.first.offered_exam.refference_date,
      mean_time: mean_time,
      median_time: median_time,
      total: @exams.size,
    }
  end

  private

    def mean_time
      total_days = 0
      @exams.each do |exam|
        service = ValidDaysCounterService.new exam.created_at.to_date, exam.finish_date
        total_days += service.call
      end
      total_days / @exams.size
    end

    def median_time
      days_took = @exams.map { |exam| ValidDaysCounterService.new(exam.created_at.to_date, exam.finish_date).call }
      sorted = days_took.sort
      len = sorted.length
      (sorted[(len - 1) / 2] + sorted[len / 2]) / 2
    end

end
