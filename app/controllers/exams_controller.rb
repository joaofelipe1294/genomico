class ExamsController < ApplicationController
  
	def start
		@exam = Exam.find params[:id]
		@samples = []
		samples = @exam.attendance.samples
		samples.each do |sample|
			@samples += sample.subsamples if sample.has_subsample
		end
		@samples += samples
	end

  def new
  end

  def edit
  end
end
