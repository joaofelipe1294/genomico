class SubSamplesController < ApplicationController
  
  #GET /sub_samples/sample/:id/new
  def new
  	sample = Sample.find params[:id]
  	@sub_sample_kinds = SubSampleKind.all.order :name
  	if sample.sample_kind == SampleKind.find_by({name: 'Swab bucal.'})
  		@sub_sample_kinds = @sub_sample_kinds - [SubSampleKind.find_by({name: 'Pellet de FISH'})]
		end
  	@sub_sample = SubSample.new({sample: sample})
  	@processing_equipments = ProcessingEquipment.all.order :name
  end

  def create
  	@sub_sample = SubSample.new sub_sample_params
  	if @sub_sample.save
  		flash[:success] = 'Subamostra cadastrada com sucesso.'
  		redirect_to workflow_path(@sub_sample.sample.attendance)
		else
			render new_sub_sample_path(@sub_sample)
		end
	end

  def edit
  end

  private 

  def sub_sample_params
  	params.require(:sub_sample).permit(
  		:sub_sample_kind_id, 
  		:processing_equipment_id,
  		:concentration,
  		:rate_260_280,
  		:rate_260_230,
  		:sample_id
		)
  end

end
