class ProductsController < ApplicationController
  before_action :user_filter
  before_action :set_product, only: [:new_open_product, :open_product]

  def in_use
  end

  # GET products/in_stock
  def in_stock
    @products = Product.includes(:brand, :stock_product).where(current_state: CurrentState.STOCK).page params[:page]
  end

  # GET products/open-product/1
  def new_open_product
  end

  # PATCH products/open-product/1
  def open_product
    if @product.change_to_in_use product_params
      flash[:success] = I18n.t :open_product_success
      redirect_to products_in_use_path
    else
      render :new_open_product
    end
  end

  private

    def set_product
      @product = Product.find params[:id]
    end

    def product_params
      params.require(:product).permit(:location, :open_at)
    end

end
