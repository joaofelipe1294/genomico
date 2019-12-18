class Product < ApplicationRecord
  belongs_to :stock_product
  belongs_to :current_state
  belongs_to :stock_entry
  belongs_to :brand
  belongs_to :stock_product
  before_validation :default_is_expired
  before_create :genertate_tag
  validates_with ProductShelfDateValidator
  validates_with ProductAmountValidator
  validates :amount, :lot, :current_state, :location, :brand, :stock_product, presence: true
  before_validation :set_stock_product
  paginates_per 17

  def display_tag
    return self.tag if self.has_tag
    "-"
  end

  private

    def default_is_expired
      return if self.shelf_life.nil?
      if self.has_shelf_life
        if self.shelf_life < Date.current
          self.is_expired = true
        else
          self.is_expired = false
        end
      else
        self.is_expired = false
      end
    end

    def genertate_tag
      return if self.stock_product.nil?
      return if self.tag
      return if self.has_tag == false
      if self.stock_product.field
        field_identifier = self.stock_product.field.name[0, 3]
      else
        field_identifier = "ALL"
      end
      if self.stock_product.field.nil?
        counter = Product.joins(:stock_product).where("stock_products.field_id IS NULL").where(has_tag: true).size + 1
      else
        counter = Product.joins(:stock_product).where("stock_products.field_id = ?", self.stock_product.field_id).where(has_tag: true).size + 1
      end
      self.tag = "#{field_identifier}#{counter}"
    end

    def set_stock_product
      return if self.stock_entry.nil?
      self.stock_product = self.stock_entry.stock_product if self.stock_entry.stock_product
    end

end
