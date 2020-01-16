class ValidDaysCounterService

  def initialize start_date, end_date
    @start_date = start_date
    @end_date = end_date
  end

  def call
    (@start_date..@end_date).select { |day| (1..5).include?(day.wday) }.size
  end

end
