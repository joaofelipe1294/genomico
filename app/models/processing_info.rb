class ProcessingInfo < ActiveRecord::Base
  belongs_to :subsample
  belongs_to :processing_equipment
end
