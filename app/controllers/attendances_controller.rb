class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]
  before_action :user_filter
  before_action :set_desease_stages_and_health_ensurances, only: [:workflow, :new]

  # GET /attendances/1
  # GET /attendances/1.json
  def show
    exam_id = params[:exam]
    if exam_id && exam_id != 'all'
      @exams_status_changes = ExamStatusChange.
                                              where(
                                                exam_id: exam_id
                                              ).
                                              order(change_date: :desc)
    else
      @exams_status_changes = ExamStatusChange.
                                              where(
                                                exam_id: @attendance.exams.ids
                                              ).
                                              order(change_date: :desc)
    end
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new(patient: Patient.find(params[:id]))
    @fields = Field.all.order :name
    @sample_kinds = SampleKind.all.order :name
    @exams = OfferedExam.where(field: @fields.first).order :name
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  # POST /attendances.json
  def create
    @attendance = Attendance.new create_attendance_params
    @attendance.attendance_status_kind = AttendanceStatusKind.IN_PROGRESS
    if @attendance.save
      flash[:success] = 'Atendimento cadastrado com sucesso.'
      redirect_to workflow_path(@attendance, {tab: 'samples'})
      User.includes(:fields).find(session[:user_id]).fields.first.set_issues_in_cache
    else
      set_desease_stages_and_health_ensurances
      @fields = Field.all.order :name
      @exams = OfferedExam.where(field: @fields.first).order :name
      @sample_kinds = SampleKind.all.order :name
      render :new
    end
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
      if @attendance.update(attendance_params)
        flash[:success] = I18n.t :attendance_update_success
        redirect_to workflow_path(@attendance)
      else
        set_desease_stages_and_health_ensurances
        render :workflow
      end
  end

  #GET attendances/1
  def workflow
    @attendance = Attendance.includes(:exams, :samples).find params[:id]
    helpers.check_attendance_status @attendance
  end

  #GET /patient/:id/attendances
  def attendances_from_patient
    @attendances = Patient.find(params[:id]).attendances.order start_date: :desc
  end

  #GET /attendances/list_code?lis_code=:lis_code
  def find_by_lis_code
    attendance = Attendance.find_by(lis_code: params[:lis_code_search])
    if attendance
      redirect_to workflow_path(attendance)
    else
      flash[:warning] = 'O código LisNet informado não esta vinculado a nenhum atendimento.'
      redirect_to home_user_index_path
    end
  end

  #PATCH
  def add_report
    attendance = Attendance.find params[:id]
    if attendance.update attendance_params
      flash[:success] = 'Laudo cadastrado com sucesso.'
      redirect_to workflow_path(attendance)
    else
      flash[:warning] = 'Erro ao adicionar laudo, tente novamente mais tarde.'
      redirect_to workflow_path(attendance)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.require(:attendance).permit(
        :desease_stage_id,
        :cid_code,
        :lis_code,
        :start_date,
        :finish_date,
        :patient_id,
        :attendance_status_kind_id,
        :doctor_name,
        :doctor_crm,
        :observations,
        :health_ensurance_id,
        :report,
        :samples,
        :exams,
        samples_attributes: [:sample_kind_id, :collection_date, :bottles_number, :storage_location],
        exams_attributes: [:offered_exam_id],
      )
    end

    def create_attendance_params
      complete_params = params.require(:attendance).permit(
        :desease_stage_id,
        :cid_code,
        :lis_code,
        :start_date,
        :patient_id,
        :attendance_status_kind_id,
        :doctor_name,
        :doctor_crm,
        :observations,
        :health_ensurance_id,
        :samples,
        :exams,
      )
      filtered_params = complete_params.clone
      if complete_params[:samples] != ""
        samples_json = JSON.parse complete_params[:samples]
        filtered_params[:samples] = samples_json.map { |sample_params| Sample.new sample_params }
      else
        filtered_params[:samples] = []
      end
      if complete_params[:exams] != ""
        exams_json = JSON.parse complete_params[:exams]
        filtered_params[:exams] = exams_json.map { |exam_params| Exam.new exam_params }
      else
        filtered_params[:exams] = []
      end
      filtered_params
    end

    def set_desease_stages_and_health_ensurances
      @desease_stages = DeseaseStage.all.order :name
      @health_ensurances = HealthEnsurance.all.order :name
    end

end
