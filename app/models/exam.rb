class Exam < ActiveRecord::Base
  attr_accessor :refference_label
  belongs_to :offered_exam
  belongs_to :exam_status_kind
  belongs_to :attendance
  belongs_to :sample
  belongs_to :subsample
  after_initialize :default_values

  def default_values
  	self.exam_status_kind = ExamStatusKind.find_by({name: 'Aguardando início'}) if self.exam_status_kind.nil?
  end

end
