require './app/reports/exam_report'

class StandProductionReport
  include ExamReport

  def initialize params
    @start_date = params[:start_date]
    @finish_date = params[:finish_date]
    @stand = params[:stand].to_sym
    stand_exams = exams_per_stand
    @exams = filter_by_date stand_exams
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

  private

    def exams_per_stand
      if @stand == :biomol
        exams = Exam.from_field Field.BIOMOL
      elsif @stand == :imunofeno
        exams = Exam.from_field Field.IMUNOFENO
      elsif @stand == :cyto
        exams = Exam.from_field Field.FISH
      end
      exams
    end

end
