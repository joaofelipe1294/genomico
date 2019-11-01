module ResponseTimeReport
  extend ActiveSupport::Concern

  def response_time
    @offered_exam_group = OfferedExamGroup.find params[:id]
    start_date = params[:start_date]
    end_date = params[:end_date]
    exams = Exam
                .joins(:offered_exam, :attendance)
                .where(exam_status_kind: ExamStatusKind.COMPLETE)
                .where("offered_exams.offered_exam_group_id = ?", @offered_exam_group.id)
    if start_date.present? && end_date.present?
      exams = exams.where("exams.finish_date BETWEEN ? AND ?", start_date, end_date)
    end
    calc_quantitative_data exams
    @pie_chart = {"Em tempo" => @total_in_time, "Atrasados" => @total_late}
    offered_exams = exams.map { |exam| exam.offered_exam }.uniq
    late_exams_stack = offered_exams.map { |offered_exam| [offered_exam.show_name, exams.where(offered_exam: offered_exam).where(was_late: true).size] }
    in_time_stack = offered_exams.map { |offered_exam| [offered_exam.show_name, exams.where(offered_exam: offered_exam).where(was_late: false).size] }
    @exams_relation = [
      { name: "Em tempo", data: in_time_stack },
      { name: "Com atraso", data: late_exams_stack },
    ]

    @exams_info = []
    offered_exams.each do |offered_exam|
      exam_group = exams.where(offered_exam: offered_exam)
      total_days = 0
      exam_group.each { |exam| total_days += week_days(exam) }
      mean_time = total_days / exam_group.size
      median_times = exam_group.map { |exam| week_days(exam) }
      median_time = median median_times
      info = {
                name: offered_exam.show_name,
                reference_time: offered_exam.refference_date,
                mean_time: mean_time,
                median_time: median_time,
                total: exam_group.size,
              }
      @exams_info << info
    end
  end

  private

    def calc_quantitative_data exams
      @patients = exams.includes(attendance: [:patient]).map { |exam| exam.attendance.patient }.uniq.size
      @exams_done = exams.size
      @total_in_time = exams.where(was_late: false).size
      @total_late = exams.where(was_late: true).size
    end

    def median(array)
      sorted = array.sort
      len = sorted.length
      (sorted[(len - 1) / 2] + sorted[len / 2]) / 2
    end

    def week_days exam
      (exam.created_at.to_date..exam.finish_date).select { |d| (1..5).include?(d.wday) }.size
    end

end
