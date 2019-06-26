class SamplesController < ApplicationController
  
  def create
  	@sample = Sample.new sample_params
  	if @sample.save
  		flash[:success] = 'Amostra cadastrada com sucesso.'
  		redirect_to workflow_path(@sample.attendance)
		else
			render @sample
		end
  end

  def new
    @sample = Sample.new({attendance_id: params[:id]})
    @sample_kinds = SampleKind.all.order :name
  end

  def edit
    @sample = Sample.find params[:id]
    @sample_kinds = SampleKind.all.order :name
  end

  def update
    @sample = Sample.find params[:id]
    if @sample.update sample_params
      flash[:success] = 'Amostra editada com sucesso.'
      redirect_to workflow_path(@sample.attendance)
    else
      flash[:warning] = 'Houve um proble no servidor, tente novamente mais tarde.'
      render edit_sample_path(@sample)
    end
  end

  def destroy
    @sample = Sample.find params[:id]
    if @sample.delete
      flash[:success] = 'Amostra removida com sucesso.'
      redirect_to workflow_path(@sample.attendance)
    else
      flash[:warning] = 'Houve um proble no servidor, tente novamente mais tarde.'
      redirect_to workflow_path(@sample.attendance)
    end
  end

  def index
    sample_kind = params[:sample_kind]
    samples = Sample.where({sample_kind: sample_kind})
    render json: samples, status: :ok, only: [:id, :refference]
  end

  private

  	def sample_params
			params.require(:sample).permit(:sample_kind_id, :collection_date, :bottles_number, :storage_location, :attendance_id)
  	end

end
