class ReagentsController < ApplicationController
  before_action :set_reagent, only: [:show, :edit, :update, :destroy]
  before_action :user_filter
  before_action :set_brands, only: [:new, :edit]

  # GET /reagents
  # GET /reagents.json
  def index
    @reagents = Reagent.includes(:field).all.order name: :asc
  end

  # GET /reagents/1
  # GET /reagents/1.json
  def show
  end

  # GET /reagents/new
  def new
    @reagent = Reagent.new
  end

  # GET /reagents/1/edit
  def edit
  end

  # POST /reagents
  # POST /reagents.json
  def create
    @reagent = Reagent.new(reagent_params)
    set_reagent_field
    if @reagent.save
      flash[:success] = I18n.t :new_reagent_success
      redirect_to reagents_path
    else
      set_brands
      render :new
    end
  end

  # PATCH/PUT /reagents/1
  # PATCH/PUT /reagents/1.json
  def update
    set_reagent_field
    if @reagent.update(reagent_params)
      flash[:success] = I18n.t :edit_reagent_success
      redirect_to reagents_path
    else
      @brands = Brand.all.order name: :asc
      render :edit
    end
  end

  # DELETE /reagents/1
  # DELETE /reagents/1.json
  def destroy
    @reagent.destroy
    respond_to do |format|
      format.html { redirect_to reagents_url, notice: 'Reagent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reagent
      @reagent = Reagent.find(params[:id])
    end

    def set_brands
      @brands = Brand.all.order name: :asc
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reagent_params
      params.require(:reagent).permit(
        :product_description,
        :name,
        :stock_itens,
        :usage_per_test,
        :brand_id,
        :total_aviable,
        :field_id,
        :first_warn_at,
        :danger_warn_at,
        :mv_code,
        :product_code,
      )
    end

    def set_reagent_field
      if params[:reagent][:belong_to_field] == "true"
        @reagent.field = User.includes(:fields).find(session[:user_id]).fields.first
      else
        @reagent.field = nil
      end
    end

end
