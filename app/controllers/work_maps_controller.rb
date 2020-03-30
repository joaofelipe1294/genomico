class WorkMapsController < ApplicationController
  before_action :set_work_map, only: [:edit, :update, :destroy]
  before_action :user_filter

  # GET /work_maps
  # GET /work_maps.json
  def index
    name = params[:name]
    date = params[:date]
    if name.present?
      work_maps = WorkMap.where('name ILIKE ?', "%#{name}%").order(:date)
    elsif date.present?
      work_maps = WorkMap.where('date BETWEEN ? AND ?', date[:initial], date[:final])
    else
      work_maps = WorkMap.all
    end
    @work_maps = work_maps.page params[:page]
  end

  # GET /work_maps/1
  # GET /work_maps/1.json
  def show
    @work_map = WorkMap.includes(:internal_codes).find(params[:id])
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
      redirect_to home_path
    else
      flash[:warning] = @work_map.errors.full_messages.first
      redirect_to new_work_map_path
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
