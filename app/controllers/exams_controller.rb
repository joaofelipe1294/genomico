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

	def initiate
		puts 'EU ESTOU AQUI !!!!'
	end

  def new
  end

  def edit
  end

  private

  	def exam_params
			params.require(:exam).permit(:offered_exam_id, :refference_label)
  	end
end
