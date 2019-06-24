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
		puts '=================================='
		puts exam_params[:refference_label]
		puts Subsample.find_by({refference_label: exam_params[:refference_label]})
		puts Sample.find_by({refference_label: exam_params[:refference_label]})
		puts '=================================='
		exam = Exam.find params[:id]
		exam.exam_status_kind = ExamStatusKind.find_by({name: 'Em andamento'})
		sample = Sample.find_by({refference_label: exam_params[:refference_label]})
		if sample.nil? == false
			exam.sample = sample
			exam.uses_subsample = false
		else
			exam.subsample = Subsample.find_by({refference_label: exam_params[:refference_label]})
			exam.uses_subsample = true
		end
		if exam.save
			flash[:success] = 'Exame iniciado.'
			redirect_to workflow_path(exam.attendance)
		else
			flash[:warning] = 'Erro ao iniciar exame, tente novamente mais tarde.'
			redirect_to workflow_path(exam.attendance)
		end
	end

  def new
  	# TODO CONTNUAR DA TROCA DE ESTADOS  DE EXAE
  end

  def edit
  end

  private

  	def exam_params
			params.require(:exam).permit(:offered_exam_id, :refference_label)
  	end
end
