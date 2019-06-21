class Sample < ActiveRecord::Base
  belongs_to :sample_kind
  belongs_to :attendance
  after_initialize :default_values
  before_save :set_refference_label
  has_many :subsamples

  def default_values
		self.has_subsample = false if self.has_subsample.nil?
		self.entry_date = Date.today if self.entry_date.nil?
	end

	private 

	def set_refference_label
		sample_kind.refference_index += 1
		sample_kind.save
		self.refference_label = "#{Date.today.year}-#{sample_kind.acronym}-#{sample_kind.refference_index}"
	end

end
