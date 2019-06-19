class SubsamplesController < ApplicationController
  before_action :set_subsample, only: [:show, :edit, :update, :destroy]

  # GET /subsamples
  # GET /subsamples.json
  def index
    @subsamples = Subsample.all
  end

  # GET /subsamples/1
  # GET /subsamples/1.json
  def show
  end

  # GET /subsamples/new
  def new
    @subsample = Subsample.new
  end

  # GET /subsamples/1/edit
  def edit
  end

  # POST /subsamples
  # POST /subsamples.json
  def create
    @subsample = Subsample.new(subsample_params)

    respond_to do |format|
      if @subsample.save
        format.html { redirect_to @subsample, notice: 'Subsample was successfully created.' }
        format.json { render :show, status: :created, location: @subsample }
      else
        format.html { render :new }
        format.json { render json: @subsample.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subsamples/1
  # PATCH/PUT /subsamples/1.json
  def update
    respond_to do |format|
      if @subsample.update(subsample_params)
        format.html { redirect_to @subsample, notice: 'Subsample was successfully updated.' }
        format.json { render :show, status: :ok, location: @subsample }
      else
        format.html { render :edit }
        format.json { render json: @subsample.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subsamples/1
  # DELETE /subsamples/1.json
  def destroy
    @subsample.destroy
    respond_to do |format|
      format.html { redirect_to subsamples_url, notice: 'Subsample was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subsample
      @subsample = Subsample.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subsample_params
      params.require(:subsample).permit(:storage_location, :refference_label, :sub_sample_kind_id, :sample_id, :collection_date)
    end
end
