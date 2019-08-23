class InternalCode < ApplicationRecord
  belongs_to :sample
  belongs_to :field
  before_validation :set_internal_code
	validates :code, uniqueness: {scope: [:field_id]}
  validates :field, :sample, :attendance, presence: true
  paginates_per 15
  belongs_to :attendance
  before_validation :set_attendance
  has_many :exam
  belongs_to :subsample

  private

  def set_attendance
    self.attendance_id = self.sample.attendance_id unless self.sample.nil? && self.attendance.nil?
  end

  def set_internal_code
    if self.code.nil?
      if self.field == Field.find_by({name: 'Imunofenotipagem'}) # FIXME: Remover esta parte quando virar o ano !!!
        new_code = InternalCode.where(field: self.field).size + 416
      else
        new_code = InternalCode.where(field: self.field).size + 1
      end
      self.code = "#{Date.today.year.to_s.slice(2, 3)}#{new_code.to_s.rjust(4,  "0")}"
    end
  end




end
