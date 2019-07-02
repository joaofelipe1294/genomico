class ExamStatusChange < ActiveRecord::Base
  validates :exam, :exam_status_kind, :change_date, presence: true
  belongs_to :exam
  belongs_to :exam_status_kind
  before_validation :default_values

  private

  	def default_values
  		self.change_date = DateTime.now if self.change_date.nil?
  	end

end
