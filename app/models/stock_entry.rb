class StockEntry < ApplicationRecord
  belongs_to :reagent
  belongs_to :responsible, class_name: :User
  validates :product, :entry_date, :responsible, presence: true
  has_one :product, dependent: :destroy
  belongs_to :stock_product
  accepts_nested_attributes_for :product, allow_destroy: true
  paginates_per 10
  before_validation :set_stock_product_in_product

  private

    def set_stock_product_in_product
      return unless self.product
      self.product.stock_product_id = self.stock_product_id if self.stock_product
    end

end
