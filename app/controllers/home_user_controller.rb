class HomeUserController < ApplicationController
  helper_method :waiting_colors, :in_progress_colors, :delayed_colors
  before_action :user_filter

  def index
    @user = User.find session[:user_id]
    unless @user.fields.empty?
      @user = User.includes(:fields).find(session[:user_id])
      @waiting_exams = helpers.waiting_exams @user.fields.first.id
      @exams_in_progress = helpers.exams_in_progress @user.fields.first.id
      @issues = Exam
                    .where.not(exam_status_kind: ExamStatusKind.COMPLETE)
                    .joins(:offered_exam)
                    .where("offered_exams.field_id = ?", @user.fields.first)
      @delayed_exams = helpers.delayed_exams @issues
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

end
