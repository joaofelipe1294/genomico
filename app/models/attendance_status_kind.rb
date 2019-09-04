class AttendanceStatusKind < ActiveRecord::Base
	validates :name, uniqueness: true
	validates :name, presence: true
	has_many :attendances

	def self.IN_PROGRESS
		AttendanceStatusKind.find_by name: 'Em andamento'
	end

	def self.COMPLETE
		AttendanceStatusKind.find_by name: 'Concluído'
	end

end
