class HomeUserController < ApplicationController
  before_action :user_filter

  def index
    @user = User.includes(:fields).find session[:user_id]
    @offered_exams = OfferedExam.where(field: @user.fields.first).where(is_active: true).order name: :asc
    @exam_status_kinds = ExamStatusKind.all.order(name: :asc)
    unless @user.fields.empty?
      @issues = helpers.find_issues filter_by: params
      @waiting_exams = helpers.waiting_exams @issues
      @exams_in_progress = helpers.exams_in_progress @issues
      @delayed_exams = find_delayed_exams
    end
  end

  private

    def find_delayed_exams
      exams = @issues
                  .where.not(exam_status_kind: ExamStatusKind.COMPLETE)
                  .where.not(exam_status_kind: ExamStatusKind.CANCELED)
      count = 0
      exams_relation = {}
      offered_exams = exams.map { |exam| exam.offered_exam }.uniq
      offered_exams.each do |offered_exam|
        open_exams = exams.where(offered_exam: offered_exam)
        total_late_exams = 0
        open_exams.each { |exam| total_late_exams += 1 if exam.is_late?}
        exams_relation[offered_exam.name] = total_late_exams
        count += total_late_exams
      end
      { count: count, relation: exams_relation }
    end

end
