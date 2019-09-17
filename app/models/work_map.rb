class WorkMap < ActiveRecord::Base
	attr_accessor :samples_ids
  before_save :set_attendances
  has_attached_file :map
  has_and_belongs_to_many :attendances
  validates :name, uniqueness: true
  validates :name, :map, :internal_code_ids, presence: true
  validates_attachment_content_type :map, :content_type => ["application/pdf"]
  paginates_per 10
	has_and_belongs_to_many :internal_codes

  private

  	def set_attendances
      self.date = Date.today if self.date.nil?
  		attendance_ids = []
			self.internal_codes.each do |internal_code|
				attendance_ids << internal_code.attendance.id
			end
			self.attendance_ids = attendance_ids.uniq
		end

end
