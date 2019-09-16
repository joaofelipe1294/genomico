class WorkMapsController < ApplicationController
  before_action :set_work_map, only: [:edit, :update, :destroy]

  # GET /work_maps
  # GET /work_maps.json
  def index
    if params[:name]
      @work_maps = WorkMap.where('name ILIKE ?', "%#{params[:name]}%").order(:date).page params[:page]
    elsif params[:date] && params[:date][:initial] != "" && params[:date][:final] != ""
      @work_maps = WorkMap.where('date BETWEEN ? AND ?', params[:date][:initial], params[:date][:final]).page params[:page]
    else
      @work_maps = WorkMap.all.page params[:page]
    end
  end

  # GET /work_maps/1
  # GET /work_maps/1.json
  def show
    @work_map = WorkMap.includes(:internal_codes).find(params[:id])
    p @work_map.internal_codes
  end

  # GET /work_maps/new
  def new
    @work_map = WorkMap.new
  end

  # GET /work_maps/1/edit
  def edit
    @sample_kinds = SampleKind.all.order :name
    @subsample_kinds = SubsampleKind.all.order :name
  end

  # POST /work_maps
  # POST /work_maps.json
  def create
    @work_map = WorkMap.new(work_map_params)
    if @work_map.save
      flash[:success] = I18n.t :create_work_map_success
      redirect_to home_user_index_path
    else
      flash[:error] = @work_map.errors.full_messages.first
      redirect_to new_work_map_path
    end
  end

  # PATCH/PUT /work_maps/1
  # PATCH/PUT /work_maps/1.json
  def update
    respond_to do |format|
      if @work_map.update(work_map_params)
        format.html { redirect_to @work_map, notice: 'Work map was successfully updated.' }
        format.json { render :show, status: :ok, location: @work_map }
      else
        format.html { render :edit }
        format.json { render json: @work_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_maps/1
  # DELETE /work_maps/1.json
  def destroy
    @work_map.destroy
    respond_to do |format|
      format.html { redirect_to work_maps_url, notice: 'Work map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_map
      @work_map = WorkMap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_map_params
      params.require(:work_map).permit(:data, :name, :map, :internal_code_ids)
    end
end
