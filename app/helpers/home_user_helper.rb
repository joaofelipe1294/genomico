module HomeUserHelper

  def waiting_exams exams
    exams_waiting_to_start = exams.where(exam_status_kind: ExamStatusKind.WAITING_START)
    waiting_exams_count = exams_waiting_to_start.size
    exams_relation = exams_waiting_to_start.group(:offered_exam).size
    relation = {}
    exams_relation.keys.each { |offered_exam| relation[offered_exam.name] = exams_relation[offered_exam] }
    { count: waiting_exams_count, relation: relation }
  end

  def exams_in_progress exams
    exams_in_progress = exams
                            .where.not(exam_status_kind: ExamStatusKind.WAITING_START)
                            .where.not(exam_status_kind: ExamStatusKind.COMPLETE)
                            .where.not(exam_status_kind: ExamStatusKind.CANCELED)
    exams_in_progress_count = exams_in_progress.size
    exams_relation = exams_in_progress.group(:offered_exam).size
    relation = {}
    exams_relation.keys.each do |offered_exam|
      relation[offered_exam.name] = exams_relation[offered_exam]
    end
    { count: exams_in_progress_count , relation: relation }
  end

  def find_issues filter_by: nil
    issues = Exam
                .joins(:offered_exam, :exam_status_kind)
                .where.not(exam_status_kind: ExamStatusKind.COMPLETE)
                .where.not(exam_status_kind: ExamStatusKind.CANCELED)
                .where("offered_exams.field_id = ?", @user.fields.first)
                .includes(:offered_exam, :internal_codes, :exam_status_kind, attendance: [:patient])
                .order(created_at: :asc)
    if filter_by[:exam_status_kind].present?
      if filter_by[:exam_status_kind] == "waiting_start"
        issues = issues.where(exam_status_kind: ExamStatusKind.WAITING_START)
      elsif filter_by[:exam_status_kind] == "in_progress"
        issues = issues.where.not(exam_status_kind: ExamStatusKind.WAITING_START)
      else
        delayed_exams = []
        issues.each { |exam| delayed_exams << exam if exam.is_late? }
        issues = Exam.where(id: delayed_exams.map {|exam| exam.id})
      end
    elsif filter_by[:offered_exam].present? && filter_by[:offered_exam] != 'Todos'
      issues = issues.where(offered_exam_id: filter_by[:offered_exam])
    else
      cache = Rails.cache.read "exams:field:#{@user.fields.first.name}"
      if cache.nil? == false && Rails.env != "test"
        issues = cache
      else
        issues = @user.fields.first.set_issues_in_cache
      end
    end
    issues
  end

end
