class HomeUserController < ApplicationController
  helper_method :waiting_colors, :in_progress

  def index
    @user = User.find session[:user_id]
    unless @user.fields.empty?
      @user = User.includes(:fields).find(session[:user_id])
      @open_exams = helpers.open_exams @user.fields.first.id
      @exams_relation = helpers.open_exams @user.fields.first.id
      @waiting_exams = helpers.waiting_exams @user.fields.first.id
    end
  end

  def waiting_colors
    chart_colors = [
      "#c6d9ec", "#b3b3ff", "#eeeedd", "#e0ebeb", "#e5e5cc", "#e0ebeb", "#c6d9ec",
      "#9fbfdf", "#6666ff", "#d4d4aa", "#a3c2c2", "#cccc99", "#a3c2c2", "#8cb3d9"
    ]
    chart_colors
  end

  def in_progress
    in_progress = [
      "#00ffcc", "#0066ff", "#6600ff", "#99ff66", "#33cccc", "#ff4dff", "#66ccff",
      "#4dffdb", "#3385ff", "#8533ff", "#77ff33", "47d1d1", "#ff99ff", "#0099e6"
    ]
    in_progress
  end

  # def exams_in_progress field_id
  #   open_exams_query = "
  #       SELECT e.id
  #       FROM exams e
  #            INNER JOIN offered_exams oe ON oe.id = e.offered_exam_id
  #       WHERE e.exam_status_kind_id <> (SELECT id FROM exam_status_kinds WHERE name = 'Concluído')
  #             AND e.exam_status_kind_id <> (SELECT id FROM exam_status_kinds WHERE name = 'Aguardando início')
  #             AND oe.field_id = ?;"
  #   status_concluded = ExamStatusKind.find_by({name: 'Concluído'})
  #   exam_ids = Exam.find_by_sql [open_exams_query, field_id]
  #   open_exams = Exam.where(id: exam_ids)
  # end

end
