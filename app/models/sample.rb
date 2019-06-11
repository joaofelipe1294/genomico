class Sample < ActiveRecord::Base
  belongs_to :sample_kind
  belongs_to :attendance
end
