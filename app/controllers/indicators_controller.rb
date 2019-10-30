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
    exams = Exam
                .joins(:offered_exam, :attendance)
                .where(exam_status_kind: ExamStatusKind.COMPLETE)
                .where("offered_exams.offered_exam_group_id = ?", 9)
                .where("exams.finish_date BETWEEN ? AND ?", 30.days.ago, 1.day.ago) #.map { |exam| exam.attendance.patient.id }.uniq.size
    @patients = exams.includes(attendance: [:patient]).map { |exam| exam.attendance.patient }.uniq.size
    @exams_done = exams.size
    @exams_relation = {}
    offered_exams = exams.map { |exam| exam.offered_exam }.uniq
    puts "============================="
    offered_exams.map { |yolo| puts yolo.name }
    puts "============================="
    offered_exams.each do |offered_exam|
      if offered_exam.mnemonyc && offered_exam.mnemonyc != ""
        @exams_relation[offered_exam.mnemonyc] = exams.where(offered_exam_id: offered_exam.id).size
      else
        @exams_relation[offered_exam.name] = exams.where(offered_exam_id: offered_exam.id).size
      end
    end






  end

end
