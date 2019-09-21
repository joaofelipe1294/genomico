module HomeUserHelper

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
    waiting_exams_relation = {}
    waiting_exams_count = 0
    result.each do |exam|
      key = exam["exam_name"]
      value = exam["total"]
      waiting_exams_relation[key] = value
      waiting_exams_count += exam["total"]
    end
    { count: waiting_exams_count, relation: waiting_exams_relation }
  end

  def exams_in_progress field_id
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
    exams_count = 0
    result.each do |exam|
      key = exam["exam_name"]
      value = exam["total"]
      exams_relation[key] = value
      exams_count += exam["total"]
    end
    { relation: exams_relation, count: exams_count }
  end

  def delayed_exams exams
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
