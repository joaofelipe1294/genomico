class ExamsController < ApplicationController
  before_action :set_exam, only: [:initiate, :tecnical_released, :in_repeat, :start, :completed, :edit, :update, :partial_released]
  before_action :set_samples_and_subsamples, only: [:start, :edit]

  def new
    @attendance = Attendance.find(params[:id])
    @fields = Field.all.order name: :asc
    @offered_exams = OfferedExam.where(field: @fields.first).order name: :asc
  end

  def create
    @exam = Exam.new({
      attendance: Attendance.find(params[:id]),
      offered_exam_id: params[:offered_exam_id]
    })
    if @exam.save
      flash[:success] = "Exame cadastrado com sucesso."
      redirect_to workflow_path(Attendance.find(params[:id]), {tab: "exams"})
      User.includes(:fields).find(session[:user_id]).fields.first.set_issues_in_cache
    else
      flash[:warning] = 'Erro ao cadastrar exame, tente novamente mais tarde.'
			redirect_to new_exam_path(@exam.attendance)
    end
  end

	def start
	end

	def edit
    @offered_exams = OfferedExam.where(is_active: true).where(field: User.find(session[:user_id]).fields.first)
	end

	def update
    @exam.internal_code_id = exam_params[:internal_code]
    @exam.offered_exam_id = exam_params[:offered_exam_id]
		if @exam.save
			flash[:success] = I18n.t :edit_exam_success
			redirect_to workflow_path(@exam.attendance, {tab: "exams"})
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
		@exam.exam_status_kind = ExamStatusKind.TECNICAL_RELEASED
		apply_changes
	end

	def in_repeat
		@exam.exam_status_kind = ExamStatusKind.IN_REPEAT
		apply_changes
	end

	def completed
		@exam.exam_status_kind = ExamStatusKind.COMPLETE_WITHOUT_REPORT
		@exam.finish_date = DateTime.now
		apply_changes
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

  # GET exams/1/add_report
  def add_report
    @exam = Exam.includes(:offered_exam, :attendance).find(params[:id])
  end

  # PATCH exams/1/save_exam_report
  def save_exam_report
    @exam = Exam.includes(:attendance).find params[:id]
    @exam.exam_status_kind = ExamStatusKind.COMPLETE
    if @exam.update exam_params
      flash[:success] = I18n.t :add_report_to_exam_success
      redirect_to workflow_path(@exam.attendance, {tab: "exams"})
      User.includes(:fields).find(session[:user_id]).fields.first.set_issues_in_cache
    else
      flash[:error] = I18n.t :add_report_to_exam_success
      redirect_to add_report_path(@exam)
    end
  end

  # GET exams/1/partial_released
  def partial_released
  end

  # PATCH exams/1/partial_released
  def change_to_partial_released
    @exam = Exam.find params[:id]
    @exam.exam_status_kind = ExamStatusKind.PARTIAL_RELEASED
    @exam.partial_released_report = exam_params[:partial_released_report]
    apply_changes
  end

  private

  	def exam_params
			params.require(:exam).permit(:offered_exam_id, :attendance, :internal_code, :report, :partial_released_report)
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
        if @exam.exam_status_kind == ExamStatusKind.COMPLETE_WITHOUT_REPORT
          redirect_to add_report_to_exam_path(@exam)
        else
          redirect_to workflow_path(@exam.attendance, {tab: "exams"})
        end
      else
				flash[:warning] = 'Erro ao alterar status de exame, tente novamente mais tarde.'
				redirect_to workflow_path(@exam.attendance, {tab: "exams"})
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
