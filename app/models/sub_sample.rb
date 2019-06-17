class SubSample < ActiveRecord::Base
  belongs_to :processing_equipment
  belongs_to :sub_sample_kind
  belongs_to :sample
end
