class PatientsController < ApplicationController
  include InstanceVariableSetter
  before_action :set_patient, only: [:show, :edit, :update]
  before_action :user_filter
  before_action :set_hospitals, only: [:new, :edit]
  before_action :set_sample_kinds, only: [:samples_from_patient]
  before_action :set_subsample_kinds, only: [:samples_from_patient]

  # GET /patients
  # GET /patients.json
  def index
    name = params[:name_search]
    medical_record = params[:medical_record]
    if name.present?
      patients = Patient.where("name ILIKE ?", "%#{name}%")
    elsif medical_record.present?
      patients = Patient.where(medical_record: medical_record)
    else
      patients = Patient.all
    end
    @patients = patients.order(:name).page params[:page]
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    @patient = Patient.find params[:id]
  end

  # GET /patients/new
  def new
    @patient = Patient.new
    # @hospitals = Hospital.all.order :name
  end

  # GET /patients/1/edit
  def edit
    # @hospitals = Hospital.all.order :name
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)
      if @patient.save
        flash[:success] = 'Paciente cadastrado com sucesso.'
        redirect_to new_attendance_path(@patient.id)
      else
        set_hospitals
        render :new
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    if @patient.update(patient_params)
      flash[:success] = I18n.t :edit_patient_success
      redirect_after_update
    else
      set_hospitals
      render :edit
    end
  end

  # GET /patients/:id/samples
  def samples_from_patient
    @patient = Patient.find params[:id]
    search_by_sample_kind = params[:sample_kind]
    search_by_subsample_kind = params[:subsample_kind]
    if search_by_sample_kind.present?
      @samples = @patient.samples.where(sample_kind_id: search_by_sample_kind).order(:created_at)
      @display = 'SAMPLE'
    elsif search_by_subsample_kind.present?
      @subsamples = @patient.subsamples.where(subsample_kind_id: search_by_subsample_kind).order(:created_at)
      @display = 'SUBSAMPLE'
    else
      @samples = @patient.samples.order(:created_at)
      @display = 'ALL'
    end
  end

  # def samples_from_patient
  #   @sample_kinds = SampleKind.all.order name: :asc
  #   @subsample_kinds = SubsampleKind.all.order name: :asc
  #   @patient = Patient.includes(:samples, :subsamples).find(params[:id])
  #   if params[:sample_kind].nil? && params[:subsample_kind].nil?
  #     @samples = @patient.samples.includes(:attendance, :subsamples)
  #     @display = 'ALL'
  #   elsif params[:sample_kind].nil? == false
  #     @samples = @patient.samples.includes(:attendance).where(sample_kind_id: params[:sample_kind])
  #     @display = 'SAMPLE'
  #   elsif params[:subsample_kind].nil? == false
  #     @subsamples = @patient.subsamples.includes(:attendance).where(subsample_kind_id: params[:subsample_kind])
  #     @display = 'SUBSAMPLE'
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :birth_date, :mother_name, :medical_record, :hospital_id, :observations)
    end

    def redirect_after_update
      attendance_id = params[:attendance]
      if attendance_id.present?
        attendance = Attendance.find attendance_id
        redirect_to workflow_path(attendance)
      else
        redirect_to home_user_index_path
      end
    end
end
