class OfferedExamsController < ApplicationController
  include InstanceVariableSetter
  before_action :set_offered_exam, only: [:show, :edit, :update, :destroy, :active_exam]
  before_action :user_filter
  before_action :set_fields, only: [:new, :edit, :index]

  # GET /offered_exams
  # GET /offered_exams.json
  def index
    field_id = params[:field]
    name = params[:name]
    if field_id.present?
      offered_exams = OfferedExam.where({field_id: field_id})
    elsif name.present?
      offered_exams = OfferedExam.where("name ILIKE ?", "%#{name}%")
    else
      offered_exams = OfferedExam.all.order(name: :asc)
    end
    @offered_exams = offered_exams.order(name: :asc).page params[:page]
  end

  # GET /offered_exams/new
  def new
    @offered_exam = OfferedExam.new
  end

  # GET /offered_exams/1/edit
  def edit
  end

  # POST /offered_exams
  # POST /offered_exams.json
  def create
    @offered_exam = OfferedExam.new(offered_exam_params)
    if @offered_exam.save
      flash[:success] = I18n.t :new_offered_exam_success
      redirect_to offered_exams_path
    else
      set_fields
      render :new
    end
  end

  # PATCH/PUT /offered_exams/1
  # PATCH/PUT /offered_exams/1.json
  def update
    if @offered_exam.update(offered_exam_params)
      flash[:success] = I18n.t :edit_offered_exam_success
      redirect_to offered_exams_path
    else
      set_fields
      render :edit
    end
  end

  # DELETE /offered_exams/1
  # DELETE /offered_exams/1.json
  def destroy
    if @offered_exam.update({is_active: false})
      flash[:success] = I18n.t :disable_offered_exam_success
    else
      flash[:warning] = @offered_exam.errors.full_messages.first
    end
    redirect_to offered_exams_path
  end

  #POST /offered_exams/:id/activate
  def active_exam
    if @offered_exam.update({is_active: true})
      flash[:success] = I18n.t :enable_offered_exam_success
    else
      flash[:warning] = @offered_exam.errors.full_messages.first
    end
    redirect_to offered_exams_path
  end

  #GET /offered_exams/field/id
  def exams_per_field
    @exams = OfferedExam.where(field: Field.find(params[:id])).where(is_active: true).order name: :asc
    render json: @exams, status: :ok, only: [:id, :name]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offered_exam
      @offered_exam = OfferedExam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offered_exam_params
      params.require(:offered_exam).permit(:name, :field_id, :is_active, :refference_date, :mnemonyc, :group)
    end
end
