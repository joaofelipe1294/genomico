class WorkMap < ActiveRecord::Base
	attr_accessor :samples_ids
  before_save :set_attendances
  has_attached_file :map
  has_and_belongs_to_many :subsamples
  has_and_belongs_to_many :attendances
  validates :name, uniqueness: true
  validates :name, :map, presence: true
  validates_attachment_content_type :map, :content_type => ["application/pdf"]
  paginates_per 10

  private

  	def set_attendances
      self.date = Date.today if self.date.nil?
  		attendance_ids = []
			subsamples.each do |subsample|
				attendance_ids.push(subsample.attendance.id)
			end
			self.attendance_ids = attendance_ids.uniq
		end

end
