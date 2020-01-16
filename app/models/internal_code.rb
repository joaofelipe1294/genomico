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
    if self.code.nil?
      if self.field == Field.IMUNOFENO
        start_date = Date.current.beginning_of_year
        finish_date = Date.current.end_of_year
        new_code = InternalCode
                              .joins(:sample)
                              .where(field: self.field)
                              .where("samples.collection_date BETWEEN ? AND ?", start_date, finish_date)
                              .size + 1
        self.code = "#{Date.today.year.to_s.slice(2, 3)}#{new_code.to_s.rjust(4,  "0")}"
      elsif (self.field == Field.BIOMOL && self.subsample.nil? == false) || (self.field == Field.FISH && self.subsample.nil? == false)
        self.code = self.subsample.refference_label
      else
        new_code = InternalCode.where(field: self.field).size + 1
      end
    end
  end

end
