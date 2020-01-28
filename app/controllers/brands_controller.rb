class BrandsController < ApplicationController
  before_action :set_brand, only: [:edit, :update, :destroy]

  # GET /brands
  # GET /brands.json
  def index
    @brands = Brand.all.order(name: :asc).page params[:page]
  end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit
  end

  # POST /brands
  # POST /brands.json
  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      flash[:success] = I18n.t :new_brand_success
      redirect_to home_user_index_path
    else
      render :new
    end
  end

  # PATCH/PUT /brands/1
  # PATCH/PUT /brands/1.json
  def update
    if @brand.update(brand_params)
      flash[:success] = I18n.t :edit_brand_success
      redirect_to home_user_index_path
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brand_params
      params.require(:brand).permit(:name)
    end
end
