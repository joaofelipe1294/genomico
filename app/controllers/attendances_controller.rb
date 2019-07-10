class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]
  before_action :user_filter


  # GET /attendances
  # GET /attendances.json
  def index
    @attendances = Attendance.all
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
    @attendance.patient = Patient.find params[:id]
    @desease_stages = DeseaseStage.all.order :name
    @health_ensurances = HealthEnsurance.all.order :name
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
    @attendance.attendance_status_kind = AttendanceStatusKind.find_by name: 'Em andamento'
    if @attendance.save
      flash[:success] = 'Atendimento cadastrado com sucesso.'
      redirect_to home_user_index_path
    else
      @desease_stages = DeseaseStage.all.order :name
      @health_ensurances = HealthEnsurance.all.order :name
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
        flash[:success] = 'Atendimento atualizado com sucesso.'
        redirect_to workflow_path(@attendance)
      else
        @desease_stages = DeseaseStage.all.order :name
        @health_ensurances = HealthEnsurance.all.order :name
        render :workflow
      end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #GET attendances/1
  def workflow
    @attendance = Attendance.find params[:id]
    @desease_stages = DeseaseStage.all.order :name
    @health_ensurances = HealthEnsurance.all.order :name
    verify_exam_status
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

    def verify_exam_status
      has_finished_all_exams = (@attendance.exams.where.not(exam_status_kind: ExamStatusKind.find_by(name: 'Concluído')).size == 0)
      if @attendance.report? && has_finished_all_exams && @attendance.attendance_status_kind != AttendanceStatusKind.find_by({name: 'Concluído'})
        # irá encerrar o exame
        new_params = {
          attendance_status_kind: AttendanceStatusKind.find_by({name: 'Concluído'}),
          finish_date: Date.today,
        }
        if @attendance.update(new_params)
          flash[:success] = 'Atendimento encerrado com sucesso.'
          redirect_to home_user_index_path
        else
          flash[:warning] = 'Erro ao encerrar o atendimento.'
          redirect_to workflow_path(@attendance)
        end
      elsif @attendance.report? == false && has_finished_all_exams
        # falta o laudo
        flash[:info] = 'Adicione o laudo para que o atendimento seja encerrado.'
      elsif @attendance.report? && has_finished_all_exams == false
        # restam exames
        flash[:info] = 'Existem exames aguardando encerramento para que o atendimento seja encerrado.'
      elsif @attendance.attendance_status_kind == AttendanceStatusKind.find_by({name: 'Concluído'})
        # atendimento já encerrado
        flash[:info] = "Atendimento encerrado em #{@attendance.finish_date.strftime("%d/%m/%Y")}."
      end
    end

end
