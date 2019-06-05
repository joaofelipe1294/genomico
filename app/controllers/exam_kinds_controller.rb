class ExamKindsController < ApplicationController
  before_action :set_exam_kind, only: [:show, :edit, :update, :destroy]

  # GET /exam_kinds
  # GET /exam_kinds.json
  def index
    @exam_kinds = ExamKind.all
  end

  # GET /exam_kinds/1
  # GET /exam_kinds/1.json
  def show
  end

  # GET /exam_kinds/new
  def new
    @exam_kind = ExamKind.new
  end

  # GET /exam_kinds/1/edit
  def edit
  end

  # POST /exam_kinds
  # POST /exam_kinds.json
  def create
    @exam_kind = ExamKind.new(exam_kind_params)

    respond_to do |format|
      if @exam_kind.save
        format.html { redirect_to @exam_kind, notice: 'Exam kind was successfully created.' }
        format.json { render :show, status: :created, location: @exam_kind }
      else
        format.html { render :new }
        format.json { render json: @exam_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exam_kinds/1
  # PATCH/PUT /exam_kinds/1.json
  def update
    respond_to do |format|
      if @exam_kind.update(exam_kind_params)
        format.html { redirect_to @exam_kind, notice: 'Exam kind was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam_kind }
      else
        format.html { render :edit }
        format.json { render json: @exam_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exam_kinds/1
  # DELETE /exam_kinds/1.json
  def destroy
    @exam_kind.destroy
    respond_to do |format|
      format.html { redirect_to exam_kinds_url, notice: 'Exam kind was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam_kind
      @exam_kind = ExamKind.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_kind_params
      params.require(:exam_kind).permit(:name, :field_id, :is_active)
    end
end
