class SubsampleKind < ActiveRecord::Base
	validates :name, :acronym, uniqueness: true
	validates :name, :acronym, presence: true

	def self.PELLET
		SubsampleKind.find_by name: 'Pellet de FISH'
	end





end
