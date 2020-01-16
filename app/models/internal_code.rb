class InternalCode < ApplicationRecord
  include ActiveModel::Validations
  validates_with InternalCodeValidator
  belongs_to :sample
  belongs_to :field
  before_validation :set_internal_code
	validates :code, uniqueness: {scope: [:field_id]}
  validates :field, :attendance, presence: true
  paginates_per 15
  belongs_to :attendance
  before_validation :set_attendance
  has_and_belongs_to_many :exams
  belongs_to :subsample
  has_and_belongs_to_many :work_maps

  private

  def set_attendance
    sample = self.sample
    subsample = self.subsample
    unless self.attendance
      self.attendance_id = sample.attendance_id if sample
      self.attendance_id = subsample.attendance_id if subsample
    end
  end

  def set_internal_code
    self.code = InternalCodeGeneratorService.new(self).call unless self.code
  end

end
