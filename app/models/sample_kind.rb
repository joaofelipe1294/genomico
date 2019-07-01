class SampleKind < ActiveRecord::Base
	validates :name, :acronym, uniqueness: true
	validates :name, :acronym, presence: true
	has_many :samples
	before_create :set_refference_index

	private

		def set_refference_index
			self.refference_index = 0 if self.refference_index.nil?
		end

end
