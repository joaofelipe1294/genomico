class Field < ActiveRecord::Base
	validates :name, uniqueness: true
	validates :name, presence: true
	has_many :offered_exams
	has_many :internal_codes
	has_and_belongs_to_many :users

	def self.FISH
		Field.find_by name: 'FISH'
	end

	def self.BIOMOL
		Field.find_by name: 'Biologia Molecular'
	end

	def self.IMUNOFENO
		Field.find_by name: 'Imunofenotipagem'
	end

	def set_issues_in_cache
		field_issues = Exam
				.where.not(exam_status_kind: ExamStatusKind.COMPLETE)
				.joins(:offered_exam)
				.where("offered_exams.field_id = ?", self.id)
				.includes(:offered_exam, :internal_code, :exam_status_kind, attendance: [:patient])
				.order(created_at: :asc)
		Rails.cache.write "exams:field:#{self.name}", field_issues, expires_in: 30.minutes
		field_issues
	end

end
