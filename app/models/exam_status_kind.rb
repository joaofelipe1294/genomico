class ExamStatusKind < ActiveRecord::Base
	validates :name, uniqueness: true
	validates :name, presence: true
	has_many :exam_status_changes
	has_many :exams
end
