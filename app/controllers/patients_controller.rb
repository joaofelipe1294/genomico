class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :user_filter

  # GET /patients
  # GET /patients.json
  def index
    if params[:name_search].nil? == false
      @patients = Patient.where("name ILIKE ?", "%#{params[:name_search]}%").order(:name).page params[:page]
    elsif params[:medical_record].nil? == false
      @patients = Patient.where({medical_record: params[:medical_record]}).page params[:page]
    else
      @patients = Patient.all.order(:name).page params[:page]
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    @patient = Patient.find params[:id]
  end

  # GET /patients/new
  def new
    @patient = Patient.new
    @hospitals = Hospital.all.order :name
  end

  # GET /patients/1/edit
  def edit
    @hospitals = Hospital.all.order :name
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)
      if @patient.save
        flash[:success] = 'Paciente cadastrado com sucesso.'
        redirect_to new_attendance_path(@patient.id)
      else
        @hospitals = Hospital.all.order :name
        render :new
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    if @patient.update(patient_params)
      flash[:success] = 'Paciente editado com sucesso.'
      if params[:attendance].nil?
        redirect_to home_user_index_path
      else
        attendance = Attendance.find params[:attendance]
        redirect_to workflow_path(attendance)
      end
    else
      @hospitals = Hospital.all.order :name
      render :edit
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    redirect_to home_user_index_path
  end

  # GET /patients/:id/samples
  def samples_from_patient
    @patient = Patient.includes(:attendances).find(params[:id])
    @attendances = @patient.attendances.includes(:samples, :subsamples).order(created_at: :desc).page params[:page]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :birth_date, :mother_name, :medical_record, :hospital_id, :observations)
    end
end
