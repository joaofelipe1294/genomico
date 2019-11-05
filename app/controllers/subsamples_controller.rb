class SubsamplesController < ApplicationController
  include InstanceVariableSetter
  before_action :set_subsample, only: [:show, :edit, :update, :destroy]
  before_action :set_subsample_kinds, only: [:new, :edit]

  # GET /subsamples
  # GET /subsamples.json
  def index
    subsample_kind_id = params[:subsample_kind]
    unless subsample_kind.present?
      @subsamples = Subsample.all
    else
      subsamples = Subsample.where({subsample_kind_id: subsample_kind_id})
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
      qubit_report: QubitReport.new,
      hemacounter_report: HemacounterReport.new
    })
  end

  # GET /subsamples/1/edit
  def edit
  end

  # POST /subsamples
  # POST /subsamples.json
  def create
    @subsample = Subsample.new(subsample_params)
    if @subsample.save
      flash[:success] = I18n.t :new_subsample_success
      redirect_to_workflow
    else
      flash[:danger] = @subsample.errors.full_messages.first
      set_subsample_kinds
      render :new
    end
  end

  # PATCH/PUT /subsamples/1
  # PATCH/PUT /subsamples/1.json
  def update
    if @subsample.update(subsample_params)
      flash[:success] = I18n.t :edit_subsample_success
      redirect_to_workflow
    else
      set_subsample_kinds
      render :edit
    end
  end

  # DELETE /subsamples/1
  # DELETE /subsamples/1.json
  def destroy
    @subsample.destroy
    flash[:success] = 'Subamostra removida com sucesso.'
    redirect_to_workflow
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
        nanodrop_report_attributes: [:id, :concentration, :rate_260_280, :rate_260_230, :_destroy],
        hemacounter_report_attributes: [:id, :leukocyte_total_count, :volume, :pellet_leukocyte_count, :cellularity ,:_destroy],
      )
    end

    def redirect_to_workflow
      redirect_to workflow_path(@subsample.sample.attendance, {tab: "samples"})
    end

end
