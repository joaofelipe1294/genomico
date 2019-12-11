class StockProductsController < ApplicationController
  before_action :set_stock_product, only: [:show, :edit, :update, :destroy]
  before_action :user_filter

  # GET /stock_products
  # GET /stock_products.json
  def index
    @stock_products = StockProduct.all.order(:name)
  end

  # GET /stock_products/1
  # GET /stock_products/1.json
  def show
  end

  # GET /stock_products/new
  def new
    @stock_product = StockProduct.new
    @unit_of_measurements = UnitOfMeasurement.all.order(:name)
    @fields = Field.all.order(:name)
  end

  # GET /stock_products/1/edit
  def edit
  end

  # POST /stock_products
  # POST /stock_products.json
  def create
    @stock_product = StockProduct.new(stock_product_params)

    respond_to do |format|
      if @stock_product.save
        format.html { redirect_to @stock_product, notice: 'Stock product was successfully created.' }
        format.json { render :show, status: :created, location: @stock_product }
      else
        format.html { render :new }
        format.json { render json: @stock_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stock_products/1
  # PATCH/PUT /stock_products/1.json
  def update
    respond_to do |format|
      if @stock_product.update(stock_product_params)
        format.html { redirect_to @stock_product, notice: 'Stock product was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock_product }
      else
        format.html { render :edit }
        format.json { render json: @stock_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_products/1
  # DELETE /stock_products/1.json
  def destroy
    @stock_product.destroy
    respond_to do |format|
      format.html { redirect_to stock_products_url, notice: 'Stock product was successfully destroyed.' }
      format.json { head :no_content }
    end
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
end
