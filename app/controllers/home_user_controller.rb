class HomeUserController < ApplicationController
  helper_method :colors

  def index
    @user = User.find session[:user_id]
    unless @user.fields.empty?
      open_exams_query = "
          SELECT e.id
          FROM exams e
               INNER JOIN offered_exams oe ON oe.id = e.offered_exam_id
          WHERE e.exam_status_kind_id <> (SELECT id FROM exam_status_kinds WHERE name = 'Concluído')
                AND e.exam_status_kind_id <> (SELECT id FROM exam_status_kinds WHERE name = 'Aguardando início')
                AND oe.field_id = ?;"
      @user = User.includes(:fields).find(session[:user_id])
      status_concluded = ExamStatusKind.find_by({name: 'Concluído'})
      exam_ids = Exam.find_by_sql [open_exams_query, @user.fields.first.id]
      @open_exams = Exam.where(id: exam_ids)
      find_open_exams @user.fields.first.id
      waiting_exams
    end
  end

  def colors
    chart_colors = [
      "#3366CC", "#DC3912", "#FF9900", "#109618", "#990099", "#3B3EAC", "#0099C6",
      "#DD4477", "#66AA00", "#B82E2E", "#316395", "#994499", "#22AA99", "#AAAA11",
      "#6633CC", "#E67300", "#8B0707", "#329262", "#5574A6", "#651067"
    ].shuffle
    chart_colors
  end

  private

  def find_open_exams field_id
    conn = ActiveRecord::Base.connection
    result = conn.execute "
    SELECT DISTINCT oe.name AS exam_name,
           COUNT(e.id) AS total,
           f.name AS field
    FROM exams e
         INNER JOIN offered_exams oe ON oe.id = e.offered_exam_id
         INNER JOIN fields f ON f.id = oe.field_id
    WHERE e.exam_status_kind_id <> (SELECT id FROM exam_status_kinds WHERE name = 'Concluído')
          AND e.exam_status_kind_id <> (SELECT id FROM exam_status_kinds WHERE name = 'Aguardando início')
          AND oe.field_id = #{conn.quote(field_id)}
    GROUP BY oe.id, f.name;"
    @exams_relation = {}
    result.each do |exam|
      key = exam["exam_name"]
      value = exam["total"]
      @exams_relation[key] = value
    end
    @exams_relation
  end

  def waiting_exams
    conn = ActiveRecord::Base.connection
    result = conn.execute "
          SELECT DISTINCT oe.name AS exam_name,
                 COUNT(oe.id) AS total
          FROM exams e
               INNER JOIN offered_exams oe ON oe.id = e.offered_exam_id
          WHERE e.exam_status_kind_id = (SELECT id FROM exam_status_kinds WHERE name = 'Aguardando início')
                AND oe.field_id = #{conn.quote(@user.fields.first.id)}
          GROUP BY oe.id;"
    @waiting_exams = {}
    result.each do |exam|
      key = exam["exam_name"]
      value = exam["total"]
      @waiting_exams[key] = value
    end
    @waiting_exams
  end

end
