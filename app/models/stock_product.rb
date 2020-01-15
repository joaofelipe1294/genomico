class StockProduct < ApplicationRecord
  belongs_to :unit_of_measurement
  belongs_to :field
  validates :name, :total_aviable, presence: true
  validates :name, uniqueness: true
  before_validation :set_total_aviable
  before_validation :set_shared_field
  validates_with StockProductMvCodeUniquenessValidator
  paginates_per 15

  private

    def set_total_aviable
      self.total_aviable = 0 unless self.total_aviable
    end

    def set_shared_field
      self.field = nil if self.is_shared
    end

end
