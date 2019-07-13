class NanodropReport < ActiveRecord::Base
  # validates :subsample, presence: true
  belongs_to :subsample
end
