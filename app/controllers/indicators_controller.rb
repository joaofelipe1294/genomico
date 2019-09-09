class IndicatorsController < ApplicationController
  def exams_per_field
  end

  def exams_in_progress
    @exams_in_progress_count = Exam.where.not(exam_status_kind: ExamStatusKind.find_by({name: 'Concluído'})).size
  end

  def concluded_exams
    if params[:start_date].nil? || params[:end_date].nil? || params[:start_date].empty? || params[:end_date].empty?
      @start_date = 2.years.ago
      @end_date = 1.second.ago
      @concluded_exams_cont = Exam.where(exam_status_kind: ExamStatusKind.find_by({name: 'Concluído'})).size
    else
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      @concluded_exams_cont = Exam
                                  .where(exam_status_kind: ExamStatusKind.find_by({name: 'Concluído'}))
                                  .where("finish_date BETWEEN ? AND ?", params[:start_date], params[:end_date]).size
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

  def imunofeno_internal_codes
    @internal_codes = InternalCode.where(field: Field.IMUNOFENO)
  end

end
