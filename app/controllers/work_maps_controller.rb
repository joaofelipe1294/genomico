class WorkMapsController < ApplicationController
  before_action :set_work_map, only: [:show, :edit, :update, :destroy]

  # GET /work_maps
  # GET /work_maps.json
  def index
    if params[:name]
      @work_maps = WorkMap.where('name ILIKE ?', "%#{params[:name]}%").order :date
    elsif params[:date] && params[:date][:initial] != "" && params[:date][:final] != ""
      @work_maps = WorkMap.where('date BETWEEN ? AND ?', params[:date][:initial], params[:date][:final])
    else
      @work_maps = WorkMap.all
    end
    
  end

  # GET /work_maps/1
  # GET /work_maps/1.json
  def show
  end

  # GET /work_maps/new
  def new
    @work_map = WorkMap.new
    @sample_kinds = SampleKind.all.order :name
    @subsample_kinds = SubsampleKind.all.order :name
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

    respond_to do |format|
      if @work_map.save
        format.html { redirect_to @work_map, notice: 'Work map was successfully created.' }
        format.json { render :show, status: :created, location: @work_map }
      else
        format.html { render :new }
        format.json { render json: @work_map.errors, status: :unprocessable_entity }
      end
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
      params.require(:work_map).permit(:data, :name, :map, :sample_ids, :subsample_ids)
    end
end
