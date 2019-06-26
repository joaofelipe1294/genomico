class WorkMap < ActiveRecord::Base
	has_attached_file :map
  validates_attachment_content_type :map, :content_type => ["application/pdf"]
  has_and_belongs_to_many :samples
  has_and_belongs_to_many :subsamples
  has_and_belongs_to_many :attendances
  attr_accessor :samples_ids

end
