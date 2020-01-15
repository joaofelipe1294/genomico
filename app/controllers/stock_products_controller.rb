class StockProductsController < ApplicationController
  before_action :set_stock_product, only: [:edit, :update]
  before_action :user_filter
  include InstanceVariableSetter
  before_action :set_instance_variables, only: [:new, :edit]
  before_action :set_fields, only: [:index]

  # GET /stock_products
  # GET /stock_products.json
  def index
    search_name = params[:name]
    if search_name.present?
      stock_products = StockProduct.where("name ILIKE ?", "%#{search_name}%")
    elsif params[:field_id].present?
      stock_products = search_by_stock_product
    else
      stock_products = StockProduct.all
    end
    @stock_products = stock_products.order(:name).page params[:page]
  end

  # GET /stock_products/new
  def new
    @stock_product = StockProduct.new
  end

  # GET /stock_products/1/edit
  def edit
  end

  # POST /stock_products
  # POST /stock_products.json
  def create
    @stock_product = StockProduct.new(stock_product_params)
    if @stock_product.save
      flash[:success] = I18n.t :new_stock_product_success
      redirect_to stock_products_path
    else
      set_instance_variables
      render :new
    end
  end

  # PATCH/PUT /stock_products/1
  # PATCH/PUT /stock_products/1.json
  def update
    if @stock_product.update(stock_product_params)
      flash[:success] = I18n.t :edit_stock_product_success
      redirect_to stock_products_path
    else
      set_instance_variables
      render :edit
    end
  end

  # GET /stock_products/reports/base-report
  def base_report
    stock_products = StockProduct.products_base_report
    @stock_products = Kaminari.paginate_array(stock_products).page(params[:page]).per(15)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_product
      @stock_product = StockProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_product_params
      params.require(:stock_product).permit(:name, :usage_per_test, :total_aviable, :first_warn_at, :danger_warn_at, :mv_code, :unit_of_measurement_id, :field_id, :is_shared)
    end

    def set_instance_variables
      set_fields
      set_units_of_measurement
    end

    def search_by_stock_product
      field_id = params[:field_id]
      if field_id == "Compartilhado"
        StockProduct.where(field: nil)
      else
        StockProduct.where(field_id: field_id)
      end
    end
end
