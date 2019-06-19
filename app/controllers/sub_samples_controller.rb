class SubSamplesController < ApplicationController
  
  #GET /sub_samples/sample/:id/new
  def new
  	@sub_sample = SubSample.new({sample: Sample.find(params[:id])})
  end

  def create
	end

  def edit
  end

  
end
