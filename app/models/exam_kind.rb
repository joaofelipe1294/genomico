class ExamKind < ActiveRecord::Base
  belongs_to :field
  validates :name, uniqueness: true
  validates :name, :field_id, presence: true
  after_initialize :default_values

  def default_values
    self.is_active = true if self.is_active.nil?
  end
  
end
