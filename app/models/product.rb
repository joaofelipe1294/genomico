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
  paginates_per 15
  before_validation :current_state_default

  def change_to_in_use params
    return false unless params[:open_at].present?
    params[:current_state] = CurrentState.IN_USE
    if self.update params
      return true
    else
      self.current_state = CurrentState.STOCK
      false
    end
  end

  def display_tag
    return self.tag if self.has_tag
    "-"
  end

  def display_shelf_life
    expired_message = "<span class='text-danger'>#{I18n.localize self.shelf_life}</span>".html_safe
    return expired_message if self.is_expired
    if self.shelf_life < Date.current
      self.update(is_expired: true)
      return expired_message
    else
      return "<span>#{I18n.localize self.shelf_life}</span>".html_safe
    end
  end

  private

    def current_state_default
      self.current_state = CurrentState.STOCK if self.current_state.nil?
    end

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
