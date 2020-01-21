class StockEntry < ApplicationRecord
  belongs_to :reagent
  belongs_to :responsible, class_name: :User
  validates_presence_of :product_amount, :entry_date, :stock_product, :responsible
  belongs_to :stock_product
  paginates_per 10
  before_validation :set_stock_product_in_product
  has_many :products, dependent: :destroy
  attr_accessor :product
  validates_with StockEntryProductAmountValidator
  validates_with StockEntryProductValidator
  after_create :create_products

  private

    def set_stock_product_in_product
      return unless self.product
      self.product.stock_product_id = self.stock_product_id if self.stock_product
    end

    def create_products
      (0...self.product_amount).each do
        attributes = self.product.attributes
        attributes[:stock_entry] = self
        Product.create attributes
      end
    end

end
