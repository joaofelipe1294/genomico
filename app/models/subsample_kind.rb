class SubsampleKind < ActiveRecord::Base
	validates :name, :acronym, uniqueness: true
	validates :name, :acronym, presence: true
end
