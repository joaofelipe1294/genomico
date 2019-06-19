class Subsample < ActiveRecord::Base
  belongs_to :sample
  belongs_to :sub_sample_kind
end
