class SubsamplesController < ApplicationController
  before_action :set_subsample, only: [:show, :edit, :update, :destroy]

  # GET /subsamples
  # GET /subsamples.json
  def index
    if params[:subsample_kind].nil?
      @subsamples = Subsample.all
    else
      subsample_kind = SubsampleKind.find params[:subsample_kind]
      subsamples = Subsample.where({subsample_kind: subsample_kind})
      render json: subsamples, status: :ok, only: [:id, :refference_label]
    end
  end

  # GET /subsamples/1
  # GET /subsamples/1.json
  def show
  end

  # GET /subsamples/new
  def new
    @subsample = Subsample.new({
      sample: Sample.find(params[:id]),
      nanodrop_report: NanodropReport.new,
      qubit_report: QubitReport.new
    })
    @subsample_kinds = SubsampleKind.all.order :name
  end

  # GET /subsamples/1/edit
  def edit
    @subsample_kinds = SubsampleKind.all.order :name
  end

  # POST /subsamples
  # POST /subsamples.json
  def create
    @subsample = Subsample.new(subsample_params)
    if @subsample.save
      if @subsample.subsample_kind == SubsampleKind.PELLET
        InternalCode.create({
          field: Field.FISH,
          subsample: @subsample,
        })
      end
      flash[:success] = "Subamostra cadastrada com sucesso."
      redirect_to workflow_path(@subsample.sample.attendance)
    else
      flash[:danger] = "Não foi possível cadastrar a subamostra."
      @subsample_kinds = SubsampleKind.all.order :name
      render :new
    end
  end

  # PATCH/PUT /subsamples/1
  # PATCH/PUT /subsamples/1.json
  def update
    if @subsample.update(subsample_params)
      flash[:success] = 'Subamostra editada com sucesso.'
      redirect_to workflow_path(@subsample.sample.attendance)
    else
      render :edit
    end
  end

  # DELETE /subsamples/1
  # DELETE /subsamples/1.json
  def destroy
    @subsample.destroy
    flash[:success] = 'Subamostra removida com sucesso.'
    redirect_to workflow_path(@subsample.sample.attendance)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subsample
      @subsample = Subsample.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subsample_params
      params.require(:subsample).permit(
        :storage_location,
        :refference_label,
        :subsample_kind_id,
        :sample_id,
        :collection_date,
        qubit_report_attributes: [:id, :concentration, :_destroy],
        nanodrop_report_attributes: [:id, :concentration, :rate_260_280, :rate_260_230, :_destroy]
      )
    end


end
