class WorkMap < ActiveRecord::Base
	has_attached_file :map
  validates_attachment_content_type :map, :content_type => ["application/pdf"]
  has_and_belongs_to_many :samples
  has_and_belongs_to_many :subsamples
  has_and_belongs_to_many :attendances
  attr_accessor :samples_ids
  after_save :set_attendances

  private

  	def set_attendances
  		attendance_ids = []
  		samples.each do |sample|
  			attendance_ids.push(sample.attendance.id)
			end
			subsamples.each do |subsample|
				attendance_ids.push(subsample.attendance.id)
			end 
			self.attendance_ids = attendance_ids
		end

end
