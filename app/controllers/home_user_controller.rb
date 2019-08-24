class HomeUserController < ApplicationController

  def index
    open_exams_query = "
        SELECT e.id
        FROM exams e
             INNER JOIN offered_exams oe ON oe.id = e.offered_exam_id
        WHERE e.exam_status_kind_id <> ?
              AND oe.field_id = ?;"
    @user = User.includes(:fields).find(session[:user_id])
    status_concluded = ExamStatusKind.find_by({name: 'Concluído'})
    exam_ids = Exam.find_by_sql [open_exams_query, status_concluded.id, @user.fields.first.id]
    @open_exams = Exam.where(id: exam_ids)
    find_open_exams
  end

  private

  def find_open_exams
    conn = ActiveRecord::Base.connection
    query =
    result = conn.execute "
          SELECT DISTINCT oe.name AS exam_name,
                 COUNT(oe.id) AS total
          FROM exams e
               INNER JOIN offered_exams oe ON oe.id = e.offered_exam_id
          WHERE e.exam_status_kind_id <> (SELECT id FROM exam_status_kinds WHERE name = 'Concluído')
                AND oe.field_id = #{conn.quote(@user.fields.first.id)}
          GROUP BY oe.id;"
    @exams_relation = {}
    result.each do |exam|
      key = exam["exam_name"]
      value = exam["total"]
      @exams_relation[key] = value
    end
    @exams_relation
  end

end
