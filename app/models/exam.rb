class Exam < ActiveRecord::Base
  attr_accessor :refference_label
  validates :exam_status_kind, :offered_exam, presence: true
  belongs_to :offered_exam
  belongs_to :exam_status_kind
  belongs_to :attendance
  has_many :exam_status_changes
  before_validation :default_values
  belongs_to :internal_code
  has_attached_file :report
  validates_attachment_content_type :report, :content_type => ["application/pdf"]
  has_attached_file :partial_released_report
  validates_attachment_content_type :partial_released_report, :content_type => ["application/pdf"]
  after_create :reload_issues_cache
  after_update :reload_issues_cache

  def change_status user_id
    ExamStatusChange.create({
      exam_status_kind_id: self.exam_status_kind_id,
      exam: self,
      change_date: DateTime.now,
      user_id: user_id
    })
    self.save
  end

  def self.in_progress_by_field field
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

  def self.complete_exams_by_field(field= '', start_date= 2.year.ago, finish_date= 10.seconds.ago)
    conn = ActiveRecord::Base.connection
    result = conn.execute "
    SELECT e.id,
           oe.name
    FROM exams e
         INNER JOIN offered_exams oe ON oe.id = e.offered_exam_id
    WHERE e.exam_status_kind_id = (SELECT id FROM exam_status_kinds WHERE name = 'Concluído')
          AND oe.field_id = (SELECT id FROM fields WHERE name = #{conn.quote(field)})
          AND e.start_date BETWEEN #{conn.quote(start_date)} AND #{conn.quote(finish_date)};"
    result.cmd_tuples
  end

  def self.health_ensurance_relation(start_date= 3.years.ago, end_date= 1.second.ago)
    conn = ActiveRecord::Base.connection
    health_ensurance_relation = {}
    HealthEnsurance.all.each do |health_ensurance|
      result = conn.execute "
        SELECT he.name,
               a.id
        FROM exams e
             INNER JOIN attendances a ON a.id = e.attendance_id
             INNER JOIN health_ensurances he ON he.id = a.health_ensurance_id
        WHERE e.exam_status_kind_id = (SELECT id FROM exam_status_kinds WHERE name = 'Concluído')
              AND he.id = (SELECT id FROM health_ensurances WHERE name = #{conn.quote(health_ensurance.name)})
              AND e.finish_date BETWEEN #{conn.quote(start_date)} AND #{conn.quote(end_date)};"
      health_ensurance_relation[health_ensurance.name] = result.cmd_tuples if result.cmd_tuples > 0
    end
    result = conn.execute "
      SELECT e.id
      FROM exams e
           INNER JOIN attendances a ON e.attendance_id = a.id
      WHERE a.health_ensurance_id IS NULL
            AND e.exam_status_kind_id = (SELECT id FROM exam_status_kinds WHERE name = 'Concluído')
            AND e.finish_date BETWEEN #{conn.quote(start_date)} AND #{conn.quote(end_date)};"
    health_ensurance_relation['Sem Plano'] = result.cmd_tuples
    health_ensurance_relation
  end

  private

  def default_values
  	self.exam_status_kind = ExamStatusKind.WAITING_START if self.exam_status_kind.nil?
  end

  def reload_issues_cache
    self.offered_exam.field.set_issues_in_cache
  end

end
