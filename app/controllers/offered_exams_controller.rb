class OfferedExamsController < ApplicationController
  before_action :set_offered_exam, only: [:show, :edit, :update, :destroy, :active_exam]

  # GET /offered_exams
  # GET /offered_exams.json
  def index
    @fields = Field.all.order(:name)
    if params.has_key? :field
      @offered_exams = OfferedExam.where({field: Field.find(params[:field])}).order(:name).page params[:page]
    elsif params.has_key? :name
      @offered_exams = OfferedExam.where("name LIKE ?", "%#{params[:name]}%").page params[:page]
    else
      @offered_exams = OfferedExam.all.order(name: :asc).page params[:page]
    end
  end

  # GET /offered_exams/1
  # GET /offered_exams/1.json
  def show
  end

  # GET /offered_exams/new
  def new
    @offered_exam = OfferedExam.new
    @fields = Field.all.order(:name)
  end

  # GET /offered_exams/1/edit
  def edit
    @fields = Field.all.order(:name)
  end

  # POST /offered_exams
  # POST /offered_exams.json
  def create
    @offered_exam = OfferedExam.new(offered_exam_params)
    if @offered_exam.save
      flash[:success] = 'Exame ofertado cadastrado com sucesso.'
      redirect_to home_admin_index_path
    else
      @fields = Field.all.order(:name)
      render :new
    end
  end

  # PATCH/PUT /offered_exams/1
  # PATCH/PUT /offered_exams/1.json
  def update
    if @offered_exam.update(offered_exam_params)
      flash[:success] = 'Exame ofertado editado com sucesso.'
      redirect_to home_admin_index_path
    else
      @fields = Field.all.order(:name)
      render :edit
    end
  end

  # DELETE /offered_exams/1
  # DELETE /offered_exams/1.json
  def destroy
    if @offered_exam.update({is_active: false})
      flash[:success] = 'Exame desativado com sucesso.'
      redirect_to home_admin_index_path
    else
      flash[:warning] = 'Houve um erro no servidor, tente novamente mais tarde'
      redirect_to offered_exams_path
    end
  end

  #POST /offered_exams/:id/activate
  def active_exam
    if @offered_exam.update({is_active: true})
      flash[:success] = 'Exame ativado com sucesso.'
      redirect_to home_admin_index_path
    else
      flash[:warning] = 'Houve um erro no servidor, tente novamente mais tarde'
      redirect_to offered_exams_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offered_exam
      @offered_exam = OfferedExam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offered_exam_params
      params.require(:offered_exam).permit(:name, :field_id, :is_active)
    end
end
