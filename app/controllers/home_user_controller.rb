class HomeUserController < ApplicationController
  helper_method :waiting_colors, :in_progress_colors, :delayed_colors
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

  def waiting_colors
    chart_colors = [
      "#c6d9ec", "#b3b3ff", "#eeeedd", "#e0ebeb", "#e5e5cc", "#e0ebeb", "#c6d9ec",
      "#9fbfdf", "#6666ff", "#d4d4aa", "#a3c2c2", "#cccc99", "#a3c2c2", "#8cb3d9"
    ]
    chart_colors
  end

  def in_progress_colors
    in_progress = [
      "#00ffcc", "#0066ff", "#6600ff", "#99ff66", "#33cccc", "#ff4dff", "#66ccff",
      "#4dffdb", "#3385ff", "#8533ff", "#77ff33", "#47d1d1", "#ff99ff", "#0099e6"
    ]
    in_progress
  end

  def delayed_colors
    delayed = [
      "#ff471a", "#ff1a75", "#ff3333", "#cc0000", "#ff1a66", "#ff0055", "#d147a3",
      "#e62e00", "#ff0066", "#ff0000", "#990000", "#b3003b", "#b3003b", "#b82e8a"
    ]
  end

  private

    def find_delayed_exams
      exams = @issues
                  .where.not(exam_status_kind: ExamStatusKinds::COMPLETE)
                  .where.not(exam_status_kind: ExamStatusKinds::CANCELED)
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
