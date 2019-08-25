class HomeUserController < ApplicationController
  helper_method :waiting_colors, :in_progress_colors, :exam_status_color_helper, :delayed_colors

  def index
    @user = User.find session[:user_id]
    unless @user.fields.empty?
      @user = User.includes(:fields).find(session[:user_id])
      @open_exams = helpers.exams_in_progress @user.fields.first.id
      @exams_relation = helpers.open_exams @user.fields.first.id
      @waiting_exams = helpers.waiting_exams @user.fields.first.id
      @issues = helpers.field_issues @user.fields.first.id
      @delayed_exams = delayed_exams @issues
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

  def exam_status_color_helper exam_status_kind # TODO: mover para application controller e utilizar nas demais views
    color = ""
    if exam_status_kind == ExamStatusKind.find_by({name: 'Aguardando início'})
      color = "dark"
    elsif exam_status_kind == ExamStatusKind.find_by({name: 'Em andamento'})
      color = "primary"
    elsif exam_status_kind == ExamStatusKind.find_by({name: 'Liberado técnico'})
      color = "info"
    elsif exam_status_kind == ExamStatusKind.find_by({name: 'Em repetição'})
      color = "warning"
    else
      color = "success"
    end
    "<label class='text-#{color}'>#{exam_status_kind.name}</label>".html_safe
  end

  def delayed_exams exams # TODO: moverpara helpers e adaptar demais métodos para que retornem um hash com a relação e contagem ...
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

end
