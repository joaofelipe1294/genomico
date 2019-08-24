class Field < ActiveRecord::Base
	validates :name, uniqueness: true
	validates :name, presence: true
	has_many :offered_exams
	has_many :internal_codes
	has_and_belongs_to_many :users
end
