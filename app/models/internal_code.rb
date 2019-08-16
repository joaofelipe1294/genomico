class InternalCode < ApplicationRecord
  belongs_to :sample
  belongs_to :field
  before_validation :set_internal_code
	validates :code, uniqueness: {scope: [:field_id]}

  private

  def set_internal_code
    if self.code.nil?
      new_code = InternalCode.where(field: self.field).size + 1
      self.code = "#{Date.today.year.to_s.slice(2, 3)}#{new_code.to_s.rjust(4,  "0")}"
    end
  end




end
