class IndicatorsController < ApplicationController
  include ExamStatusKinds

  def exams_per_field
  end

  def exams_in_progress
    @exams_in_progress_count = Exam.
                                    where.not(
                                      exam_status_kind: ExamStatusKinds::COMPLETE
                                    ).size
  end

  def concluded_exams
    start_date = params[:start_date]
    end_date = params[:end_date]
    if start_date.present? && end_date.present?
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      @concluded_exams_cont = Exam
                                  .where(exam_status_kind: ExamStatusKind.find_by({name: 'Concluído'}))
                                  .where("finish_date BETWEEN ? AND ?", start_date, end_date).size
    else
      @start_date = 2.years.ago
      @end_date = 1.second.ago
      @concluded_exams_cont = Exam.where(exam_status_kind: ExamStatusKind.find_by({name: 'Concluído'})).size
    end
  end

  def health_ensurances_relation
    if params[:start_date].nil? || params[:end_date].nil? || params[:start_date].empty? || params[:end_date].empty?
      @concluded_exams_cont = Exam.where(exam_status_kind: ExamStatusKind.find_by({name: 'Concluído'})).size
      @exams_relation = Exam.health_ensurance_relation
    else
      @concluded_exams_cont = Exam
                                  .where(exam_status_kind: ExamStatusKind.find_by({name: 'Concluído'}))
                                  .where("finish_date BETWEEN ? AND ?", params[:start_date], params[:end_date]).size
      @exams_relation = Exam.health_ensurance_relation params[:start_date], params[:end_date]
    end
  end

  def response_time
    @offered_exam_group = OfferedExamGroup.find params[:id]
    if params[:start_date].present?
      start_date = params[:start_date]
    else
      start_date = 3.years.ago
    end

    if params[:end_date].present?
      end_date = params[:end_date]
    else
      end_date = Date.today
    end


    exams = Exam
                .joins(:offered_exam, :attendance)
                .where(exam_status_kind: ExamStatusKind.COMPLETE)
                .where("offered_exams.offered_exam_group_id = ?", @offered_exam_group.id)
                .where("exams.finish_date BETWEEN ? AND ?", start_date, end_date)
    @patients = exams.includes(attendance: [:patient]).map { |exam| exam.attendance.patient }.uniq.size
    @exams_done = exams.size
    @total_in_time = exams.where(was_late: false).size
    @total_late = exams.where(was_late: true).size
    @pie_chart_data = {}
    @pie_chart_data["Em tempo"] = @total_in_time
    @pie_chart_data["Atrasados"] = @total_late
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
      exam_group.each { |exam| total_days += (exam.created_at.to_date..exam.finish_date).select { |d| (1..5).include?(d.wday) }.size }
      mean_time = total_days / exam_group.size
      median_times = exam_group.map { |exam| (exam.created_at.to_date..exam.finish_date).select { |d| (1..5).include?(d.wday) }.size }
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

  def median(array)
    sorted = array.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2
  end

end
