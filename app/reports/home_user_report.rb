class HomeUserReport

  def initialize params
    @field = params[:field]
    @open_exams = find_open_exams
  end

  def find_issues filter_by: nil
    exam_status_kind = filter_by[:exam_status_kind]
    offered_exam = filter_by[:offered_exam]
    return filter_by_exam_status_kind(@open_exams, exam_status_kind) if exam_status_kind
    return @open_exams.where(offered_exam_id: offered_exam) if offered_exam && offered_exam != 'Todos'
    get_from_cache
  end

  def waiting_exams_count
    @open_exams.waiting_start.size
  end

  def waiting_exams_relation
    @open_exams.waiting_start.group("offered_exams.name").count
  end

  def in_progress_count
    @open_exams.where.not(exam_status_kind: ExamStatusKind.WAITING_START).size
  end

  def in_progress_relation
    @open_exams.where.not(exam_status_kind: ExamStatusKind.WAITING_START).group("offered_exams.name").count
  end

  def delayed_exams_count
    late_exams(@open_exams).size
  end

  def delayed_exams_relation
    late_exams(@open_exams).joins(:offered_exam).group("offered_exams.name").count
  end

  private

    def filter_by_exam_status_kind issues, exam_status_kind
      if exam_status_kind == "waiting_start"
        issues.waiting_start
      elsif exam_status_kind == "in_progress"
        issues.where.not(exam_status_kind: ExamStatusKind.WAITING_START)
      else
        late_exams issues
      end
    end

    def get_from_cache
      cache = Rails.cache.read "exams:field:#{@field.name}"
      if cache && Rails.env != "test"
        exams = cache
      else
        exams = @field.set_issues_in_cache
      end
      exams
    end

    def find_open_exams
      Exam
          .includes(:offered_exam, :internal_codes, :exam_status_kind, attendance: [:patient])
          .from_field(@field)
          .where.not(exam_status_kind: [ExamStatusKind.COMPLETE, ExamStatusKind.CANCELED])
          .order created_at: :asc
    end

    def exams_waiiting_start
      Exam.from_field(@field).waiting_start
    end

    def late_exams exams
      exams = exams.select { |exam| exam.is_late? }
      Exam.where(id: exams)
    end

end
