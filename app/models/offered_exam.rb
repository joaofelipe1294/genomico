class OfferedExam < ActiveRecord::Base
  belongs_to :field
  validates :name, uniqueness: true
  validates :name, :field, presence: true
  after_initialize :default_params

  def default_params
  	self.is_active = true if self.is_active.nil?
  end

end
