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
  has_many :exams
  belongs_to :subsample

  private

  def set_attendance
    self.attendance_id = self.sample.attendance_id if self.sample.nil? == false && self.attendance.nil? == true
    self.attendance_id = self.subsample.attendance_id if self.subsample.nil? == false && self.attendance.nil? == true
  end

  def set_internal_code
    if self.code.nil?
      if self.field == Field.find_by({name: 'Imunofenotipagem'}) # FIXME: Remover esta parte quando virar o ano !!!
        new_code = InternalCode.where(field: self.field).size + 416
        self.code = "#{Date.today.year.to_s.slice(2, 3)}#{new_code.to_s.rjust(4,  "0")}"
      elsif (self.field == Field.find_by(name: 'Biologia Molecular') && self.subsample.nil? == false) || (self.field == Field.FISH && self.subsample.nil? == false)
        self.code = self.subsample.refference_label
      else
        new_code = InternalCode.where(field: self.field).size + 1
      end
    end
  end

end
