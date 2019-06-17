class SamplesController < ApplicationController
  
  def create
  	@sample = Sample.new sample_params
  	if @sample.save
  		flash[:success] = 'Amostra cadastrada com sucesso.'
  		redirect_to workflow_path(@sample.attendance)
		else
			render workflow_path(@sample.attendance)
		end
  end

  private

  	def sample_params
			params.require(:sample).permit(:sample_kind_id, :collection_date, :bottles_number, :storage_location, :attendance_id)
  	end

end
