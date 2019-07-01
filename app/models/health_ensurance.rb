class HealthEnsurance < ActiveRecord::Base
	validates :name, uniqueness: true
	validates :name, presence: true
	has_many :attendances
end
