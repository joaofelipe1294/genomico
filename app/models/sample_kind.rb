class SampleKind < ActiveRecord::Base
	validates :name, :acronym, uniqueness: true
	validates :name, :acronym, presence: true
	has_many :samples
end
