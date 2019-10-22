class InternalCodesController < ApplicationController
  include InstanceVariableSetter
  before_action :user_filter
  before_action :set_subsample_kinds, only: :biomol_internal_codes

  def index
    @internal_codes = InternalCode.
                                  includes(:sample, :exams).
                                  where(field_id: params[:field_id]).
                                  order(created_at: :desc).
                                  page params[:page]
  end

  def create
    @internal_code = InternalCode.new({
      field_id: session[:field_id],
      sample_id: params[:id]
      })
    if @internal_code.save
      flash[:success] = I18n.t :new_internal_code_success
    else
      flash[:error] = @internal_code.errors.full_messages.first
    end
    redirect_to_samples_tab
  end

  def destroy
    @internal_code = InternalCode.includes(:attendance).find params[:id]
    if @internal_code.delete
      flash[:success] = I18n.t :remove_internal_code_success
    else
      flash[:warning] = @internal_code.errors.full_messages.first
    end
    redirect_to_samples_tab
  end

  def imunofeno_internal_codes
    search_code = params[:code]
    internal_codes = InternalCode.
                                  includes(:sample, :attendance).
                                  where(field: Field.IMUNOFENO).
                                  order(created_at: :desc)
    if search_code && search_code.empty? == false 
      internal_codes = internal_codes.where(code: search_code)
    end
    @internal_codes = internal_codes.page params[:page]
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
    subsample_kind_id = params[:subsample_kind_id]
    internal_codes = InternalCode
                                .where(field: Field.BIOMOL)
                                .where.not(subsample: nil)
                                .includes(subsample: [:subsample_kind, :qubit_report, :nanodrop_report, :patient])
                                .includes(:attendance)
                                .order(created_at: :desc)
    if subsample_kind_id && subsample_kind_id != 'Todos'
      internal_codes = internal_codes.
                                      joins(:subsample).
                                      where("subsamples.subsample_kind_id = ?", subsample_kind_id)
    end
    @internal_codes = internal_codes.page params[:page]
  end

  private

    def redirect_to_samples_tab
      redirect_to workflow_path(@internal_code.attendance, {tab: "samples"})
    end

end
