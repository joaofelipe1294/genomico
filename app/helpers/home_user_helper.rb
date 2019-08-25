module HomeUserHelper

  def open_exams field_id
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
    exams_relation = {}
    result.each do |exam|
      key = exam["exam_name"]
      value = exam["total"]
      exams_relation[key] = value
    end
    exams_relation
  end

  def waiting_exams field_id
    conn = ActiveRecord::Base.connection
    result = conn.execute "
          SELECT DISTINCT oe.name AS exam_name,
                 COUNT(oe.id) AS total
          FROM exams e
               INNER JOIN offered_exams oe ON oe.id = e.offered_exam_id
          WHERE e.exam_status_kind_id = (SELECT id FROM exam_status_kinds WHERE name = 'Aguardando início')
                AND oe.field_id = #{conn.quote(field_id)}
          GROUP BY oe.id;"
    waiting_exams = {}
    result.each do |exam|
      key = exam["exam_name"]
      value = exam["total"]
      waiting_exams[key] = value
    end
    waiting_exams
  end

  def exams_in_progress field_id
    open_exams_query = "
        SELECT e.id
        FROM exams e
             INNER JOIN offered_exams oe ON oe.id = e.offered_exam_id
        WHERE e.exam_status_kind_id <> (SELECT id FROM exam_status_kinds WHERE name = 'Concluído')
              AND e.exam_status_kind_id <> (SELECT id FROM exam_status_kinds WHERE name = 'Aguardando início')
              AND oe.field_id = ?;"
    exam_ids = Exam.find_by_sql [open_exams_query, field_id]
    open_exams = Exam.where(id: exam_ids)
    open_exams
  end

end
