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

	end

  def edit
  end

  
end
