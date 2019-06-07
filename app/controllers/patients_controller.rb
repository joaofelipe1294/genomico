class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  # GET /patients
  # GET /patients.json
  def index
    if params[:name].nil? == false
      @patients = Patient.where("name ILIKE ?", "%#{params[:name]}%").order(:name).page params[:page]
    elsif params[:medical_record].nil? == false
      @patients = Patient.where({medical_record: params[:medical_record]}).page params[:page]
    else
      @patients = Patient.all.order(:name).page params[:page]
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)
      if @patient.save
        flash[:success] = 'Paciente cadastrado com sucesso.'
        redirect_to home_user_index_path
      else
        render :new
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    if @patient.update(patient_params)
      flash[:success] = 'Paciente atualizado com sucesso.'
      redirect_to home_user_index_path
    else
      render :edit
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :birth_date, :mother_name, :medical_record)
    end
end
