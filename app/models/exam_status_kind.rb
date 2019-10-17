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

	def self.PARTIAL_RELEASED
		ExamStatusKind.find_by name: 'Liberado parcial'
	end

	def self.COMPLETE_WITHOUT_REPORT
		ExamStatusKind.find_by name: 'Concluído (sem laudo)'
	end

	def self.CANCELED
		ExamStatusKind.find_by name: 'Cancelado'
	end

	def display_name
    text_style = "text-primary" if self == ExamStatusKind.IN_PROGRESS
    text_style = "text-success" if self == ExamStatusKind.COMPLETE
    text_style = "text-warning" if self == ExamStatusKind.IN_REPEAT
    text_style = "text-secondary" if self == ExamStatusKind.TECNICAL_RELEASED
		text_style = "text-info" if self == ExamStatusKind.PARTIAL_RELEASED
		text_style = "text-dark" if self == ExamStatusKind.COMPLETE_WITHOUT_REPORT
		text_style = "text-danger" if self == ExamStatusKind.CANCELED
    "<label class='#{text_style}'>#{self.name}</label>".html_safe
	end

end
