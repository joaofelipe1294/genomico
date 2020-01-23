class StockProduct < ApplicationRecord
  belongs_to :unit_of_measurement
  belongs_to :field
  validates :name, presence: true
  validates :name, uniqueness: true
  before_validation :set_shared_field
  validates_with StockProductMvCodeUniquenessValidator
  paginates_per 15
  has_many :products

  def self.products_base_report
    StockProduct.includes(:unit_of_measurement).all.order(:name).select do |stock_product|
      stock_product
                  .products
                  .where("products.current_state_id = ? OR products.current_state_id = ?", CurrentState.STOCK.id, CurrentState.IN_USE.id)
                  .size > 0
    end
  end

  def total_in_use
    self.products.where(current_state: CurrentState.IN_USE).sum("products.amount")
  end

  def total_aviable
    self.products.where(current_state: CurrentState.STOCK).sum("products.amount")
  end

  private

    def set_shared_field
      self.field = nil if self.is_shared
    end

end
