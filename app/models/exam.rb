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

  private

  def default_values
  	self.exam_status_kind = ExamStatusKind.find_by({name: 'Aguardando início'}) if self.exam_status_kind.nil?
    self.start_date = DateTime.now if self.start_date.nil?
  end

end
