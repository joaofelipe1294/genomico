class Subsample < ActiveRecord::Base
  belongs_to :subsample_kind
  belongs_to :sample
end
