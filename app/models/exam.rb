class Exam < ActiveRecord::Base
  attr_accessor :refference_label
  validates :exam_status_kind, presence: true
  belongs_to :offered_exam
  belongs_to :exam_status_kind
  belongs_to :attendance
  belongs_to :sample
  belongs_to :subsample
  has_many :exam_status_changes
  before_validation :default_values

  def self.in_progress_by_field field
    conn = ActiveRecord::Base.connection
    result = conn.execute "SELECT e.id,
                         oe.name,
                         f.name
                  FROM exams e
                       INNER JOIN offered_exams oe ON oe.id = e.offered_exam_id
                       INNER JOIN fields f ON f.id = oe.field_id
                  WHERE e.exam_status_kind_id <> (SELECT id FROM exam_status_kinds WHERE name = 'Concluído')
                    AND f.id = (select id from fields where name = #{conn.quote(field)});"
    result.cmd_tuples
  end

  private

  def default_values
  	self.exam_status_kind = ExamStatusKind.find_by({name: 'Aguardando início'}) if self.exam_status_kind.nil?
    self.start_date = DateTime.now if self.start_date.nil?
  end

end
