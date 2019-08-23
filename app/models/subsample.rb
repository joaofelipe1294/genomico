class Subsample < ActiveRecord::Base
  validates :sample, :subsample_kind, presence: true
  belongs_to :sample
  belongs_to :attendance
  belongs_to :subsample_kind
  has_and_belongs_to_many :work_maps
  has_one :qubit_report, dependent: :destroy
  has_one :nanodrop_report, dependent: :destroy
  accepts_nested_attributes_for :qubit_report, allow_destroy: true
  accepts_nested_attributes_for :nanodrop_report, allow_destroy: true
  before_save :add_default_values
  has_many :internal_codes

  private

    def add_default_values
  		subsample_kind.refference_index += 1
  		subsample_kind.save
  		self.refference_label = "#{Date.today.year.to_s.slice(2, 3)}-#{subsample_kind.acronym}-#{subsample_kind.refference_index.to_s.rjust(5,  "0")}"
  		self.collection_date = DateTime.now
  		self.sample.update({has_subsample: true})
      self.attendance = sample.attendance
    end

end
