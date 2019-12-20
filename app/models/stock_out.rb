class StockOut < ApplicationRecord
  belongs_to :stock_product
  belongs_to :product
  belongs_to :responsible, class_name: :User
  before_validation :set_stock_product
  validates :product, :date, :responsible, :stock_product, presence: true

  private

    def set_stock_product
      return if self.product.nil?
      self.stock_product = self.product.stock_product unless self.stock_product
    end

end
