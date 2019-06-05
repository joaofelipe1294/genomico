class ExamKind < ActiveRecord::Base
  belongs_to :field
  validates :name, uniqueness: true
  validates :name, :field_id, presence: true
end
