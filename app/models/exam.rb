class Exam < ActiveRecord::Base
  attr_accessor :refference_label
  belongs_to :offered_exam
  belongs_to :exam_status_kind
  belongs_to :attendance
  belongs_to :sample
  belongs_to :subsample
  after_initialize :default_values
  before_save :set_start_date
  has_many :exam_status_changes

  private

  def default_values
  	self.exam_status_kind = ExamStatusKind.find_by({name: 'Aguardando início'}) if self.exam_status_kind.nil?
  end

  def set_start_date
    self.start_date = DateTime.now
  end

end
