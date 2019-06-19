class Subsample < ActiveRecord::Base
  belongs_to :sub_sample_kind
  belongs_to :sample
end
