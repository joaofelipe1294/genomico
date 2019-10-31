module ExamReports
  extend ActiveSupport::Concern

  class_methods do

    def in_progress_by_field field
      conn = ActiveRecord::Base.connection
      result = conn.execute "
        SELECT e.id,
               oe.name,
               f.name
        FROM exams e
             INNER JOIN offered_exams oe ON oe.id = e.offered_exam_id
             INNER JOIN fields f ON f.id = oe.field_id
        WHERE e.exam_status_kind_id <> (SELECT id FROM exam_status_kinds WHERE name = 'Concluído')
          AND f.id = (select id from fields where name = #{conn.quote(field)});"
      result.cmd_tuples
    end

  end

end
