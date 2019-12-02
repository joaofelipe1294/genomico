class StockEntriesController < ApplicationController
  include InstanceVariableSetter
  before_action :set_stock_entry, only: [:show, :edit, :update, :destroy]
  before_action :user_filter
  before_action :set_instance_variables, only: [:new, :edit]

  # GET /stock_entries
  # GET /stock_entries.json
  def index
    @stock_entries = StockEntry
                                .all
                                .includes(:reagent, :current_state, :responsible)
                                .order(entry_date: :desc)
                                .page params[:page]
  end

  # GET /stock_entries/1
  # GET /stock_entries/1.json
  def show
  end

  # GET /stock_entries/new
  def new
    @stock_entry = StockEntry.new
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
      return redirect_to display_new_tag_path(@stock_entry) if @stock_entry.has_tag
      return redirect_to stock_entries_path if @stock_entry.has_tag == false
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
      redirect_to stock_entries_path
    else
      set_instance_variables
      render :edit
    end

  end

  # DELETE /stock_entries/1
  # DELETE /stock_entries/1.json
  # def destroy
  #   @stock_entry.destroy
  #   respond_to do |format|
  #     format.html { redirect_to stock_entries_url, notice: 'Stock entry was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_entry
      @stock_entry = StockEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_entry_params
      params.require(:stock_entry).permit(
        :reagent_id,
        :lot,
        :shelf_life,
        :is_expired,
        :amount,
        :entry_date,
        :current_state_id,
        :location,
        :responsible_id,
        :tag,
        :has_shelf_life,
        :has_tag
      )
    end

    def set_instance_variables
      set_fields
      @units_of_measurement = UnitOfMeasurement.all.order(:name)
      @current_states = CurrentState.all.order(:name)
      @users = User.where(user_kind: UserKind.USER).order(:login)
      @reagent_relation = {
        0.to_s =>  Reagent.where(field: nil).order(:name),
        Field.BIOMOL.id.to_s => Reagent.where(field: Field.BIOMOL).order(:name),
        Field.IMUNOFENO.id.to_s => Reagent.where(field: Field.IMUNOFENO).order(:name),
        Field.FISH.id.to_s => Reagent.where(field: Field.FISH).order(:name),
        Field.CYTOGENETIC.id.to_s => Reagent.where(field: Field.CYTOGENETIC).order(:name),
        Field.ANATOMY.id.to_s => Reagent.where(field: Field.ANATOMY).order(:name),
      }
    end
end
