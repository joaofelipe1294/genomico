class StockEntry < ApplicationRecord
  belongs_to :reagent
  belongs_to :responsible, class_name: :User
  validates_presence_of :product_amount, :entry_date, :stock_product, :responsible
  belongs_to :stock_product
  paginates_per 10
  has_many :products, dependent: :destroy
  attr_accessor :product
  validates_with StockEntryProductAmountValidator
  validates_with StockEntryProductValidator
  after_create :create_products
  after_initialize :set_product

  private

    def set_product
      return unless self.product
      self.product = Product.new(self.product) if self.product.is_a? Hash
      self.product.stock_product = self.stock_product
    end

    def create_products
      (0...self.product_amount).each do
        attributes = self.product.attributes
        attributes[:stock_entry] = self
        attributes[:stock_product] = self.stock_product
        Product.create attributes
      end
    end

end
