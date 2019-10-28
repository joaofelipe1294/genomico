class OfferedExamGroup < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :offered_exams
end
