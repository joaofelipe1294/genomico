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
    exams_in_progress_count = exams_in_progress.size
    exams_relation = exams_in_progress.group(:offered_exam).size
    relation = {}
    exams_relation.keys.each do |offered_exam|
      relation[offered_exam.name] = exams_relation[offered_exam]
    end
    { count: exams_in_progress_count , relation: relation }
  end

  def delayed_exams filter_by: nil
    if filter_by.nil? || filter_by == 'Todos'
      exams = Exam
                  .includes(:offered_exam)
                  .where.not(exam_status_kind: ExamStatusKind.COMPLETE)
                  .joins(:offered_exam)
                  .where("offered_exams.field_id = ?", @user.fields.first)
    else
      exams = Exam
                  .includes(:offered_exam)
                  .where.not(exam_status_kind: ExamStatusKind.COMPLETE)
                  .joins(:offered_exam)
                  .where("offered_exams.field_id = ?", @user.fields.first)
                  .where(offered_exam_id: filter_by)
    end
    late_exams = []
    exams.each do |exam|
      created_at = exam.created_at.to_date
      refference_date = exam.offered_exam.refference_date
      business_days_since_creation = (created_at..Date.today).select { |d| (1..5).include?(d.wday) }.size
      late_exams.push exam if business_days_since_creation > refference_date
    end
    exams_relation = {}
    late_exams.each do |exam|
      if exams_relation.key? exam.offered_exam.name
        exams_relation[exam.offered_exam.name] += 1
      else
        exams_relation[exam.offered_exam.name] = 1
      end
    end
    { count: late_exams.size, relation: exams_relation }
  end

  def find_issues filter_by: nil
    if filter_by.nil? || filter_by == 'Todos'
      issues = Exam
                    .where.not(exam_status_kind: ExamStatusKind.COMPLETE)
                    .joins(:offered_exam)
                    .where("offered_exams.field_id = ?", @user.fields.first)
                    .includes(:offered_exam, :internal_code, :exam_status_kind, attendance: [:patient])
                    .order(created_at: :asc)
    else
      issues = Exam
                    .where.not(exam_status_kind: ExamStatusKind.COMPLETE)
                    .joins(:offered_exam)
                    .where("offered_exams.field_id = ?", @user.fields.first)
                    .where(offered_exam_id: filter_by)
                    .includes(:offered_exam, :internal_code, :exam_status_kind, attendance: [:patient])
                    .order(created_at: :asc)
    end
    issues
  end

end
