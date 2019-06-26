class WorkMap < ActiveRecord::Base
	has_attached_file :map
  validates_attachment_content_type :map, :content_type => ["application/pdf"]
end
