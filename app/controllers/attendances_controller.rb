class AttendancesController < ApplicationController
  include JsonParser
  include InstanceVariableSetter
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]
  before_action :user_filter
  before_action :set_health_ensurances, only: [:workflow, :new]

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
    @attendance = Attendance.new(patient: Patient.find(params[:patient]))
    set_dependencies
  end

  # POST /attendances
  # POST /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      flash[:success] = 'Atendimento cadastrado com sucesso.'
      redirect_to workflow_path(@attendance, {tab: 'samples'})
    else
      set_health_ensurances
      set_dependencies
      render :new
    end
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
      if @attendance.update(attendance_params)
        flash[:success] = I18n.t :attendance_update_success
        redirect_to workflow_path(@attendance, {tab: params[:tab]})
      else
        set_health_ensurances
        flash[:warning] = @attendance.errors.full_messages.first
        redirect_to workflow_path(@attendance, {tab: params[:tab]})
      end
  end

  #GET attendances/1
  def workflow
    @attendance = Attendance.includes(:exams, :samples).find params[:id]
    @tab = params[:tab]
    check_attendance_status
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      filtered_params = params.require(:attendance).permit(
        :desease_stage,
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
      treat_params filtered_params
    end

    def set_dependencies
      @fields = Field.all.order :name
      @sample_kinds = SampleKind.all.order :name
      @exams = OfferedExam.where(field: @fields.first).order :name
    end

    def treat_params parameters
      parameters = parse_list :exams, Exam, parameters
      parameters = parse_list :samples, Sample, parameters
      parameters
    end

    def check_attendance_status
      if @attendance.complete?
        flash[:info] = "Atendimento encerrado em #{I18n.l @attendance.finish_date.to_date}."
      elsif @attendance.all_exams_are_complete?
        if @attendance.conclude
          flash[:success] = I18n.t :complete_attendance_success
        else
          flash[:error] = I18n.t :server_error_message
        end
      elsif @attendance.has_pendent_reports?
        flash[:info] = I18n.t :pending_reports_message
      end
    end

end
