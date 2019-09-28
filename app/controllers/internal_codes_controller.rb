class InternalCodesController < ApplicationController
  before_action :user_filter

  def index
    @internal_codes = InternalCode.includes(:sample, :exams).where(field_id: params[:field_id]).order(created_at: :desc).page params[:page]
  end

  def new
  end

  def create
    user = User.includes(:fields).find(session[:user_id])
    if user.fields.size == 1
      if params[:target] == "sample"
        @internal_code = InternalCode.create({
          field: user.fields.first,
          sample: Sample.find(params[:id])
        })
        flash[:success] = I18n.t :new_internal_code_success
      else
        @internal_code = InternalCode.create({
          field: user.fields.first,
          subsample: Subsample.find(params[:id])
        })
        flash[:success] = I18n.t :new_internal_code_success
      end
      redirect_to workflow_path(@internal_code.attendance, {tab: "samples"})
    else
      if params[:target] == "sample"
        @internal_code = InternalCode.new(sample: Sample.find(params[:id]))
      else
        @internal_code = InternalCode.new(subsample: Subsample.find(params[:id]))
      end
      @fields = [Field.IMUNOFENO, Field.BIOMOL, Field.FISH]
    end
  end

  def destroy
    internal_code = InternalCode.includes(:attendance).find params[:id]
    sample = internal_code.sample
    if internal_code.delete
      flash[:success] = I18n.t :remove_internal_code_success
      redirect_to workflow_path(internal_code.attendance, {tab: "samples"})
    else
      flash[:warning] = 'Erro ao remover código interno, tente novamente mais tarde.'
      redirect_to workflow_path(internal_code.sample.attendance)
    end
  end

  def imunofeno_internal_codes
    if params[:code].nil? || params[:code].empty?
      @internal_codes = InternalCode
                                    .includes(:sample, :attendance)
                                    .where(field: Field.IMUNOFENO)
                                    .order(created_at: :desc)
                                    .page params[:page]
    else
      @internal_codes = InternalCode
                                    .includes(:sample, :attendance)
                                    .where(code: params[:code])
                                    .page params[:page]
    end
  end

  # GET internal_codes/1
  def show
    @internal_code = InternalCode.includes(:sample, :subsample, :field).find_by(code: params[:code])
    if @internal_code
      render json: @internal_code, status: :ok, include: [:field, :sample, :subsample]
    elsif @internal_code.nil?
      render json: {}, status: :not_found
    else
      render json: {}, status: :internal_server_error
    end
  end

  # GET internal_codes/biomol_internal_codes
  def biomol_internal_codes
    @internal_codes = InternalCode.where(field: Field.BIOMOL).order created_at: :desc
  end

  private

  def internal_code_attributes
    params.require(:internal_code).permit(:sample_id, :field_id, :subsample_id)
  end

end
