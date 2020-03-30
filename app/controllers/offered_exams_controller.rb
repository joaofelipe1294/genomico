class OfferedExamsController < ApplicationController
  include InstanceVariableSetter
  before_action :set_offered_exam, only: [:show, :edit, :update, :destroy, :active_exam]
  before_action :user_filter
  before_action :set_fields, only: [:new, :edit, :index]

  # GET /offered_exams
  # GET /offered_exams.json
  def index
    respond_to do |format|

      format.html do
        field_id = params[:field]
        name = params[:name]
        if field_id.present?
          offered_exams = OfferedExam.where({field_id: field_id})
        elsif name.present?
          offered_exams = OfferedExam.where("name ILIKE ?", "%#{name}%")
        else
          offered_exams = OfferedExam.all.order(name: :asc)
        end
        @offered_exams = offered_exams.includes(:field).order(name: :asc).page params[:page]
      end
      format.json do
        offered_exams = OfferedExam.where(field_id: params[:field]).where(is_active: true).order(:name)
        render json: offered_exams, status: :ok
      end

    end


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
    return update_using_path_params if params[:is_active].present?
    if @offered_exam.update(offered_exam_params)
      update_success
    else
      set_fields
      render :edit
    end
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

    def update_using_path_params
      if @offered_exam.update is_active: params[:is_active]
        return update_success
      else
        flash[:error] = @offered_exam.errors.full_messages
        redirect_to offered_exams_path
      end
    end

    def update_success
      flash[:success] = I18n.t :edit_offered_exam_success
      redirect_to offered_exams_path
    end
end
