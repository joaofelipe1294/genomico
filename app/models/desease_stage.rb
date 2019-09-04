class DeseaseStage < ActiveRecord::Base
	validates :name, uniqueness: true
	validates :name, presence: true
	has_many :attendances

	def self.DRM
		DeseaseStage.find_by name: 'DRM'
	end

	def self.RETURN
		DeseaseStage.find_by name: 'Recaída'
	end

	def self.DIAGNOSIS
		DeseaseStage.find_by name: 'Diagnóstico'
	end

end
