class SubsampleKind < ActiveRecord::Base
	validates :name, :acronym, uniqueness: true
	validates :name, :acronym, presence: true

	def self.PELLET
		SubsampleKind.find_by name: 'Pellet de FISH'
	end

	def self.RNA
		SubsampleKind.find_by name: 'RNA'
	end

	def self.VIRAL_DNA
		SubsampleKind.find_by name: 'DNA viral'
	end

	def self.DNA
		SubsampleKind.find_by name: 'DNA'
	end

end
