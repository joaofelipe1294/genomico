class Subsample < ActiveRecord::Base
  belongs_to :subsample_kind
  belongs_to :sample
  has_one :nanodrop_report
  has_one :qubit_report
  accepts_nested_attributes_for :nanodrop_report, :qubit_report
  before_save :add_default_values

  private

  def add_default_values
		subsample_kind.refference_index += 1
		subsample_kind.save
		self.refference_label = "#{Date.today.year}-#{subsample_kind.acronym}-#{subsample_kind.refference_index}"
		self.collection_date = DateTime.now
		self.sample.update({has_subsample: true})
  end


end
