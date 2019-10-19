class ExamsController < ApplicationController
  before_action :set_exam, only: [:initiate, :change_exam_status, :start, :completed, :edit, :update, :partial_released, :remove_report]
  before_action :set_internal_codes, only: [:start, :edit]
  before_action :user_filter
  before_action :set_offered_exams, only: [:new, :edit]

  def new
    @exam = Exam.new(attendance_id: params[:id])
    @fields = Field.all.order name: :asc
  end

  def create
    @exam = Exam.new(exam_params)
    if @exam.save
      flash[:success] = I18n.t :new_exam_success
      redirect_to workflow_path(@exam.attendance, {tab: "exams"})
    else
      show_error
    end
  end

	def start
	end

	def edit
	end

	def update
    if @exam.update(exam_params)
			flash[:success] = I18n.t :edit_exam_success
			redirect_to workflow_path(@exam.attendance, {tab: "exams"})
		else
      show_error
		end
	end

  def change_exam_status
    @exam.exam_status_kind_id = params[:new_status]
    apply_changes
  end

  def completed
		@exam.exam_status_kind = ExamStatusKind.COMPLETE_WITHOUT_REPORT
		@exam.finish_date = DateTime.now
		apply_changes
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

	def initiate
    @exam.internal_code_id = exam_params[:internal_code]
    @exam.start_date = Date.today
    @exam.exam_status_kind = ExamStatusKind.IN_PROGRESS
		apply_changes
	end

  def exams_from_patient
    field_id = params[:field_id]
    @fields = Field.all.order(name: :asc)
    @patient = Patient.find(params[:id])
    @exams = Exam.where(attendance_id: Attendance.where(patient_id: params[:id])).includes(:offered_exam)
    if field_id && field_id != "0"
      @exams = @exams.joins(:offered_exam).where("offered_exams.field_id = ?", field_id)
    end
    @exams = Kaminari.paginate_array(@exams).page(params[:page]).per(10)
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

  def remove_report
    if params[:kind] == "partial_released"
      if @exam.update({exam_status_kind: ExamStatusKind.IN_PROGRESS, partial_released_report: nil})
        flash[:success] = I18n.t :remove_report_success
        redirect_to workflow_path(@exam.attendance, {tab: "exams"})
      else
        flash[:error] = @exam.erros.complete_message.first
        redirect_to workflow_path(@exam.attendance, {tab: "exams"})
      end
    end
  end

  private

  	def exam_params
			params.require(:exam).permit(:offered_exam_id, :attendance, :internal_code, :report, :partial_released_report, :attendance_id, :internal_code_id)
  	end

  	def set_exam
  		@exam = Exam.find params[:id]
		end

		def apply_changes
			ExamStatusChange.create({
				exam_status_kind: @exam.exam_status_kind,
				exam: @exam,
				change_date: DateTime.now,
        user_id: session[:user_id]
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

		def set_internal_codes
			@internal_codes = InternalCode.includes(:sample, :subsample).where(attendance: @exam.attendance).where(field: @exam.offered_exam.field)
		end

    def set_offered_exams
      @offered_exams = OfferedExam
                                  .where(is_active: true)
                                  .where(field: session[:field_id])
                                  .order(name: :asc)
    end

    def show_error
      flash[:warning] = @exam.errors.full_messages.first
			redirect_to workflow_path(@exam.attendance)
    end

end
