class ProductsController < ApplicationController
  before_action :user_filter

  def in_use
  end

  def in_stock
    @products = Product.includes(:brand, :stock_product).where(current_state: CurrentState.STOCK).page params[:page]
  end
end
