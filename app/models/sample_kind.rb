class SampleKind < ActiveRecord::Base
	validates :name, :acronym, uniqueness: true
	validates :name, :acronym, presence: true
	has_many :samples
	before_create :set_refference_index

	def self.BIOPSY
		SampleKind.find_by name: 'Biópsia de tecidos.'
	end

	def self.SWAB
		SampleKind.find_by name: 'Swab bucal.'
	end

	def self.PARAFFIN_BLOCK
		SampleKind.find_by name: 'Bloco de parafina.'
	end

	def self.LIQUOR
		SampleKind.find_by name: 'Liquor'
	end

	def self.PERIPHERAL_BLOOD
		SampleKind.find_by name: 'Sangue periférico'
	end

	def self.BONE_MARROW
		SampleKind.find_by name: 'Medula óssea'
	end

	private

		def set_refference_index
			self.refference_index = 0 if self.refference_index.nil?
		end

end
