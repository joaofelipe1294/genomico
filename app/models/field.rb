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

end
