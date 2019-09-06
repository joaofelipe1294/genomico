class ExamsController < ApplicationController
  # TODO: Revisar e remover todo código de lógica existente na controller !
  before_action :set_exam, only: [:initiate, :tecnical_released, :in_repeat, :start, :completed, :edit, :update]
  before_action :set_samples_and_subsamples, only: [:start, :edit]

  def new
    @attendance = Attendance.find(params[:id])
    @fields = Field.all.order name: :asc
    @offered_exams = OfferedExam.where({field: @fields.first}).order name: :asc
  end

  def create
    @exam = Exam.new({
      attendance: Attendance.find(params[:id]),
      offered_exam_id: params[:offered_exam_id]
    })
    if @exam.save
      flash[:success] = "Exame cadastrado com sucesso."
      redirect_to workflow_path(Attendance.find(params[:id]))
    else
      flash[:warning] = 'Erro ao cadastrar exame, tente novamente mais tarde.'
			redirect_to new_exam_path(@exam.attendance)
    end
  end

	def start
	end

	def edit
	end

	def update
		# select_label_refference
    @exam.internal_code_id = exam_params[:internal_code]
		if @exam.save
			flash[:success] = "Exame editado com sucesso."
			redirect_to workflow_path(@exam.attendance)
		else
			flash[:warning] = 'Erro ao editar exame, tente novamente mais tarde.'
			redirect_to workflow_path(@exam.attendance)
		end
	end

	def initiate
		@exam.exam_status_kind = ExamStatusKind.IN_PROGRESS
    @exam.internal_code_id = exam_params[:internal_code]
    @exam.start_date = Date.today
		apply_changes
	end

	def tecnical_released
		@exam.exam_status_kind = ExamStatusKind.find_by({name: 'Liberado técnico'})
		apply_changes
	end

	def in_repeat
		@exam.exam_status_kind = ExamStatusKind.find_by({name: 'Em repetição'})
		apply_changes
	end

	def completed
		@exam.exam_status_kind = ExamStatusKind.find_by({name: 'Concluído'})
		@exam.finish_date = DateTime.now
		apply_changes
		if @exam.attendance.exams.where.not(exam_status_kind: ExamStatusKind.find_by(name: 'Concluído')).size == 0
			flash[:info] = 'Adicione o laudo para encerrar o atendimento.'
		end
	end

  def exams_from_patient
    @fields = Field.all.order name: :asc
    @patient = Patient.find params[:id]
    attendances = @patient.attendances.order start_date: :desc
    patient_exams = []
    if params[:field_id].nil? || params[:field_id] == "0"
      attendances.each do |attendance|
        patient_exams = patient_exams + attendance.exams.includes(:offered_exam, :exam_status_kind)
      end
    else
      connection = ActiveRecord::Base.connection
      result = connection.execute("
        SELECT e.id
        FROM patients p
             INNER JOIN attendances a ON a.patient_id = p.id
             INNER JOIN exams e ON e.attendance_id = a.id
             INNER JOIN offered_exams oe ON oe.id = e.offered_exam_id
        WHERE p.id = #{connection.quote @patient.id} AND oe.field_id = #{connection.quote params[:field_id]};")
      result.each do |row|
        patient_exams.push Exam.find(row["id"])
      end
    end
    @exams = Kaminari.paginate_array(patient_exams).page(params[:page]).per(10)
  end

  private

  	def exam_params
			params.require(:exam).permit(:offered_exam_id, :attendance, :internal_code)
  	end

  	def set_exam
  		@exam = Exam.find params[:id]
		end

		def apply_changes
			ExamStatusChange.create({
				exam_status_kind: @exam.exam_status_kind,
				exam: @exam,
				change_date: DateTime.now,
        user: User.find(session[:user_id])
			})
			if @exam.save
				flash[:success] = "Status de exame alterado para #{@exam.exam_status_kind.name}."
				redirect_to workflow_path(@exam.attendance)
			else
				flash[:warning] = 'Erro ao alterar status de exame, tente novamente mais tarde.'
				redirect_to workflow_path(@exam.attendance)
			end
		end

		def set_samples_and_subsamples
			@internal_codes = InternalCode.includes(:sample, :subsample).where(attendance: @exam.attendance).where(field: @exam.offered_exam.field)
		end

		def select_label_refference
			sample = Sample.find_by({refference_label: exam_params[:refference_label]})
			if sample.nil? == false
				@exam.sample = sample
				@exam.uses_subsample = false
			else
				@exam.subsample = Subsample.find_by({refference_label: exam_params[:refference_label]})
				@exam.uses_subsample = true
			end
			@exam
		end

end
