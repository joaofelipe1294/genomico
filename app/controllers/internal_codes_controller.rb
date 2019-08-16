class InternalCodesController < ApplicationController
  before_action :set_internal_code, only: [:show, :edit, :update, :destroy]

  # GET /internal_codes
  # GET /internal_codes.json
  def index
    @internal_codes = InternalCode.all
  end

  # GET /internal_codes/1
  # GET /internal_codes/1.json
  def show
  end

  # GET /internal_codes/new
  def new
    @internal_code = InternalCode.new
  end

  # GET /internal_codes/1/edit
  def edit
  end

  # POST /internal_codes
  # POST /internal_codes.json
  def create
    @internal_code = InternalCode.new(internal_code_params)

    respond_to do |format|
      if @internal_code.save
        format.html { redirect_to @internal_code, notice: 'Internal code was successfully created.' }
        format.json { render :show, status: :created, location: @internal_code }
      else
        format.html { render :new }
        format.json { render json: @internal_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /internal_codes/1
  # PATCH/PUT /internal_codes/1.json
  def update
    respond_to do |format|
      if @internal_code.update(internal_code_params)
        format.html { redirect_to @internal_code, notice: 'Internal code was successfully updated.' }
        format.json { render :show, status: :ok, location: @internal_code }
      else
        format.html { render :edit }
        format.json { render json: @internal_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /internal_codes/1
  # DELETE /internal_codes/1.json
  def destroy
    @internal_code.destroy
    respond_to do |format|
      format.html { redirect_to internal_codes_url, notice: 'Internal code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internal_code
      @internal_code = InternalCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def internal_code_params
      params.require(:internal_code).permit(:code, :field_id)
    end
end
