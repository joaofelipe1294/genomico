class ProductsController < ApplicationController
  include InstanceVariableSetter
  before_action :user_filter
  before_action :set_product, only: [:new_open_product, :open_product]
  before_action :set_fields, only: [:in_stock]

  # GET products/in_use
  def in_use
    @products = Product.includes(:brand, :stock_product).where(current_state: CurrentState.IN_USE).page params[:page]
  end

  # GET products/in_stock
  def in_stock
    if params[:name].present?
      products = find_by_name
      # products = Product
      #                   .includes(:brand)
      #                   .where(current_state: CurrentState.STOCK)
      #                   .joins(:stock_product)
      #                   .where("stock_products.name ILIKE ?", "%#{params[:name]}%")
    elsif params[:field_id].present?
      products = find_by_field
      # if params[:field_id] == "Compartilhado"
      #   products = Product
      #                     .includes(:brand)
      #                     .where(current_state: CurrentState.STOCK)
      #                     .joins(:stock_product)
      #                     .where("stock_products.is_shared = true")
      # else
      #   products = Product
      #                     .includes(:brand)
      #                     .where(current_state: CurrentState.STOCK)
      #                     .joins(:stock_product)
      #                     .where("stock_products.field_id = ?", params[:field_id])
      # end
    else
      products = Product
                        .includes(:stock_product, :brand)
                        .where(current_state: CurrentState.STOCK)
    end
    @products = products.page params[:page]
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

  # GET products/next-product-to-open/:id
  def next_product_to_open
    @product = Product.includes(:stock_product).find params[:id]
    @remaining_products = Product.where(current_state: CurrentState.STOCK).where(stock_product_id: @product.stock_product).size - 1
  end

  private

    def set_product
      @product = Product.find params[:id]
    end

    def product_params
      params.require(:product).permit(:location, :open_at)
    end

    def find_by_field
      if params[:field_id] == "Compartilhado"
        products = Product
                          .includes(:brand)
                          .where(current_state: CurrentState.STOCK)
                          .joins(:stock_product)
                          .where("stock_products.is_shared = true")
      else
        products = Product
                          .includes(:brand)
                          .where(current_state: CurrentState.STOCK)
                          .joins(:stock_product)
                          .where("stock_products.field_id = ?", params[:field_id])
      end
      products
    end

    def find_by_name
      Product
            .includes(:brand)
            .where(current_state: CurrentState.STOCK)
            .joins(:stock_product)
            .where("stock_products.name ILIKE ?", "%#{params[:name]}%")
    end

end
