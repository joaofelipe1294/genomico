class SamplesController < ApplicationController

  def create
  	@sample = Sample.new sample_params
  	if @sample.save
  		flash[:success] = 'Amostra cadastrada com sucesso.'
  		redirect_to workflow_path(@sample.attendance, {tab: "samples"})
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
      flash[:success] = I18n.t :edit_sample_success
      redirect_to workflow_path(@sample.attendance, {tab: "samples"})
    else
      flash[:warning] = 'Houve um proble no servidor, tente novamente mais tarde.'
      render edit_sample_path(@sample)
    end
  end

  def destroy
    @sample = Sample.find params[:id]
    if @sample.internal_codes.size > 0
      flash[:warning] = 'Esta amostra está vinculada a pelo menos um exame, por isso não pode ser remomvido.'
      redirect_to workflow_path(@sample.attendance, {tab: "samples"})
    elsif @sample.internal_codes.size == 0 && @sample.delete
      flash[:success] = I18n.t :remove_sample_success
      redirect_to workflow_path(@sample.attendance, {tab: "samples"})
    else
      flash[:warning] = 'Houve um proble no servidor, tente novamente mais tarde.'
      redirect_to workflow_path(@sample.attendance, {tab: "samples"})
    end
  end

  def index
    sample_kind = SampleKind.find params[:sample_kind]
    samples = Sample.where({sample_kind: sample_kind})
    render json: samples, status: :ok, only: [:id, :refference_label]
  end

  private

  	def sample_params
			params.require(:sample).permit(
        :sample_kind_id,
        :collection_date,
        :receipt_notice, 
        :storage_location,
        :attendance_id
      )
  	end

end
