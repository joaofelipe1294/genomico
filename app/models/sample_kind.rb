class SampleKind < ActiveRecord::Base
	validates :name, uniqueness: true
	validates :name, presence: true
	has_many :samples
end
