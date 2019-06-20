class Subsample < ActiveRecord::Base
  belongs_to :subsample_kind
  belongs_to :sample
  has_one :nanodrop_report
  has_one :qubit_report
  accepts_nested_attributes_for :nanodrop_report, :qubit_report
end
