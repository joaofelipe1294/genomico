class ReagentsController < ApplicationController
  before_action :set_reagent, only: [:show, :edit, :update, :destroy]
  before_action :user_filter
  before_action :set_related_data, only: [:new, :edit]

  # GET /reagents
  # GET /reagents.json
  def index
    set_fields
    set_reagents
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
      set_related_data
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
      set_related_data
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
        :unit_of_measurement_id
      )
    end

    def set_reagent_field
      field = reagent_params[:field_id]
      if field == "Compartilhado"
        @reagent.field = nil
      else
        @reagent.field_id = field
      end
    end

    def set_reagents
      reagent_name = params[:name]
      reagent_field = params[:field_id]
      reagents = Reagent.includes(:field).all.order(name: :asc).page params[:page]
      reagents = reagents.where("name ILIKE ?", "%#{reagent_name}%") if reagent_name
      if reagent_field
        reagents = reagents.where(field_id: reagent_field) if reagent_field != "Compartilhado"
        reagents = reagents.where(field_id: nil) if reagent_field == "Compartilhado"
      end
      @reagents = reagents
    end

    def set_fields
      @fields = Field.all.order(name: :asc)
    end

    def set_related_data
      set_fields
      @units_of_measurement = UnitOfMeasurement.all.order(name: :asc)
      @brands = Brand.all.order name: :asc
    end

end
