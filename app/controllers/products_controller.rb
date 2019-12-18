class ProductsController < ApplicationController
  def in_use
  end

  def in_stock
    @products = Product.includes(:brand, :stock_product).where(current_state: CurrentState.STOCK).page params[:page]
  end
end
