class ExamStatusKind < ActiveRecord::Base
	validates :name, uniqueness: true
	validates :name, presence: true
	has_many :exam_status_changes
	has_many :exams

	def self.IN_PROGRESS
		ExamStatusKind.find_by name: 'Em andamento'
	end

	def self.TECNICAL_RELEASED
		ExamStatusKind.find_by name: 'Liberado técnico'
	end

	def self.IN_REPEAT
		ExamStatusKind.find_by name: 'Em repetição'
	end

	def self.COMPLETE
		ExamStatusKind.find_by name: 'Concluído'
	end

	def self.WAITING_START
		ExamStatusKind.find_by name: 'Aguardando início'
	end

end
