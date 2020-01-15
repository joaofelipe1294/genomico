class Product < ApplicationRecord
  belongs_to :stock_product
  belongs_to :current_state
  belongs_to :stock_entry
  belongs_to :brand
  before_validation :default_is_expired
  before_create :genertate_tag
  validates_with ProductShelfDateValidator
  validates_with ProductAmountValidator
  validates :amount, :lot, :current_state, :location, :brand, :stock_product, presence: true
  before_validation :set_stock_product
  paginates_per 12
  before_validation :current_state_default
  after_create :set_open_at_value
  after_create :update_stock_product_aviable

  def find_next_in_stock
    ProductFinderService.new(self).call
  end

  def change_to_in_use params
    return false unless params[:open_at].present?
    params[:current_state] = CurrentState.IN_USE
    if self.update params
      update_stock_product_aviable operation: :change_to_in_use
      return true
    else
      self.current_state = CurrentState.STOCK
      false
    end
  end

  private

    def current_state_default
      self.current_state = CurrentState.STOCK unless self.current_state
    end

    def set_open_at_value
      self.update(open_at: Date.current) if self.current_state == CurrentState.IN_USE
    end

    def default_is_expired
      shelf_life = self.shelf_life
      return unless shelf_life
      if self.has_shelf_life && shelf_life < Date.current
        self.is_expired = true
      else
        self.is_expired = false
      end
    end

    def genertate_tag
      tag = ProductTagGeneratorService.new(self).call
      self.tag = tag if tag
    end

    def set_stock_product
      stock_entry = self.stock_entry
      return unless stock_entry
      stock_product = stock_entry.stock_product
      self.stock_product = stock_product if stock_product
    end

    def update_stock_product_aviable operation: :add_to_stock
      service = StockProductAmountManagerService.new(self, operation)
      stock_values_updated = service.call
      self.stock_product.update stock_values_updated
    end

end
