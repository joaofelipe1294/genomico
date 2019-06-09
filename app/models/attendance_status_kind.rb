class AttendanceStatusKind < ActiveRecord::Base
	validates :name, uniqueness: true
end
