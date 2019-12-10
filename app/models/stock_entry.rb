class StockEntry < ApplicationRecord
  belongs_to :reagent
  belongs_to :responsible, class_name: :User
  validates :product, :entry_date, :responsible, presence: true
  has_one :product
  belongs_to :stock_product
  accepts_nested_attributes_for :product
  paginates_per 10
  before_validation :set_stock_product

  private

    def set_stock_product
      self.stock_product = self.product.stock_product if self.product
    end


end
