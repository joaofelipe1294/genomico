class Sample < ActiveRecord::Base
  belongs_to :sample_kind
  belongs_to :attendance
  after_initialize :default_values

  def default_values
		self.has_sub_sample = false if self.has_sub_sample.nil?
		self.entry_date = Date.today if self.entry_date.nil?
	end

end
