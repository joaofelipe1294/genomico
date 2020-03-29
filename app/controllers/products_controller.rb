class ProductsController < ApplicationController
  include InstanceVariableSetter
  before_action :user_filter
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    kind = params[:kind]
    if kind == :in_use.to_s
      products = find_products(CurrentState.IN_USE)
    elsif kind == :stock.to_s
      products = find_products(CurrentState.STOCK)
    end
    @products = products.page params[:page]
  end

  # GET products/open-product/1
  def edit
  end

  # PATCH products/open-product/1
  def update
    if @product.change_to_in_use product_params
      flash[:success] = I18n.t :open_product_success
      redirect_to products_path(kind: :in_use)
    else
      render :new_open_product
    end
  end

  # GET products/next-product-to-open/:id
  def show
    @remaining_products = Product.where(current_state: CurrentState.STOCK).where(stock_product_id: @product.stock_product).size - 1
  end

  def destroy
    if @product.destroy
      flash[:success] = I18n.t :product_destroyed_success
    else
      flash[:warning] = @product.errors.full_messages.first
    end
    redirect_to stock_entry_path(@product.stock_entry)
  end

  private

    def set_product
      @product = Product.includes(:stock_product).find params[:id]
    end

    def product_params
      params.require(:product).permit(:location, :open_at)
    end

    def find_by_field status
      field_id =  params[:field_id]
      products = Product.where(current_state: status).joins(:stock_product, :brand)
      if field_id == "Compartilhado"
        products = products.where("stock_products.is_shared = true")
      else
        products = products.where("stock_products.field_id = ?", field_id)
      end
      products
    end

    def find_by_name status
      Product
            .joins(:stock_product, :brand)
            .where(current_state: status)
            .where("stock_products.name ILIKE ?", "%#{params[:name]}%")
    end

    def find_products current_state
      if params[:name].present?
        products = find_by_name current_state
      elsif params[:field_id].present?
        products = find_by_field current_state
      else
        products = Product
                          .includes(:stock_product, :brand)
                          .where(current_state: current_state)
      end
      products
    end

end
