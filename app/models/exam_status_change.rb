class ExamStatusChange < ActiveRecord::Base
  validates_presence_of :exam, :new_status
  belongs_to :exam
  before_validation :default_values
  belongs_to :user

  private

  	def default_values
  		self.change_date = DateTime.now if self.change_date.nil?
  	end

end
