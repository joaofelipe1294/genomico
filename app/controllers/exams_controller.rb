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
		exam = Exam.find params[:id]
		new_params = exam_params
		new_params[:exam_status_kind] = ExamStatusKind.find_by({name: 'Em andamento'})
		if exam.update new_params
			flash[:success] = 'Exame iniciado.'
			redirect_to workflow_path(exam.attendance)
		else
			flash[:warning] = 'Erro ao iniciar exame, tente novamente mais tarde.'
			redirect_to workflow_path(exam.attendance)
		end
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
