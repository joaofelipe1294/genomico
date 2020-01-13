class StockEntriesController < ApplicationController
  include InstanceVariableSetter
  before_action :set_stock_entry, only: [:show, :edit, :update, :destroy]
  before_action :user_filter
  before_action :set_instance_variables, only: [:new, :edit]

  # GET /stock_entries
  # GET /stock_entries.json
  def index
    @stock_products = StockProduct.all.order(:name)
    if params[:stock_product_id].present?
      stock_entries = StockEntry
                                .includes(:responsible, product: [:current_state, :brand, :stock_product => [:field]] )
                                .where(stock_product_id: params[:stock_product_id])
    else
      stock_entries = StockEntry
                                .includes(:responsible, product: [:current_state, :brand, :stock_product => [:field]])
                                .all
    end
    @stock_entries = stock_entries.page params[:page]
  end

  # GET /stock_entries/1
  # GET /stock_entries/1.json
  def show
  end

  # GET /stock_entries/new
  def new
    @stock_entry = StockEntry.new(product: Product.new)
  end

  # GET /stock_entries/1/edit
  def edit
  end

  # POST /stock_entries
  # POST /stock_entries.json
  def create
    @stock_entry = StockEntry.new(stock_entry_params)
    if @stock_entry.save
      flash[:success] = I18n.t :new_stock_entry_success
      return redirect_to display_new_tag_path(@stock_entry) if @stock_entry.product.has_tag
      return redirect_to stock_entries_path if @stock_entry.product.has_tag == false
    else
      set_instance_variables
      render :new
    end
  end

  def display_new_tag
    @stock_entry = StockEntry.find params[:id]
  end

  # PATCH/PUT /stock_entries/1
  # PATCH/PUT /stock_entries/1.json
  def update
    if @stock_entry.update(stock_entry_params)
      flash[:success] = I18n.t :edit_stock_entry_success
      redirect_to stock_entries_path
    else
      set_instance_variables
      render :edit
    end
  end

  # DELETE /stock/entries/1
  def destroy
    if @stock_entry.destroy
      flash[:success] = I18n.t :remove_stock_entry_success
    else
      flash[:warning] = I18n.t :remove_stock_entry_error
    end
    redirect_to stock_entries_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_entry
      @stock_entry = StockEntry
                              .includes(:responsible, product: [:current_state, :brand, :stock_product => [:field]] )
                              .find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_entry_params
      params.require(:stock_entry).permit(
        :stock_product_id,
        :is_expired,
        :entry_date,
        :responsible_id,
        product_attributes: [
          :id,
          :lot,
          :amount,
          :current_state_id,
          :brand_id,
          :location,
          :tag,
          :has_shelf_life,
          :has_tag,
          :shelf_life
        ]
      )
    end

    def set_instance_variables
      set_fields
      @units_of_measurement = UnitOfMeasurement.all.order(:name)
      @current_states = CurrentState.all.order(:name)
      @users = User.where(user_kind: UserKind.USER).order(:login)
      @brands = Brand.all.order(:name)
      @stock_product_relation = {
        0.to_s =>  StockProduct.where(field: nil).order(:name),
        Field.BIOMOL.id.to_s => StockProduct.where(field: Field.BIOMOL).order(:name),
        Field.IMUNOFENO.id.to_s => StockProduct.where(field: Field.IMUNOFENO).order(:name),
        Field.FISH.id.to_s => StockProduct.where(field: Field.FISH).order(:name),
        Field.CYTOGENETIC.id.to_s => StockProduct.where(field: Field.CYTOGENETIC).order(:name),
        Field.ANATOMY.id.to_s => StockProduct.where(field: Field.ANATOMY).order(:name),
      }
    end
end
