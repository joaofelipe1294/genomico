class InternalCodesController < ApplicationController

  def index
    @internal_codes = InternalCode.includes(:sample, :exams).where(field_id: params[:field_id]).order(created_at: :desc).page params[:page]
  end

  def new
    if params[:target] == "sample"
      @internal_code = InternalCode.new(sample: Sample.find(params[:id]))
      @fields = [Field.find_by({name: 'Imunofenotipagem'})]
    else
      @internal_code = InternalCode.new(subsample: Subsample.find(params[:id]))
      @fields = [Field.find_by({name: 'Biologia Molecular'}), Field.find_by({name: 'FISH'})]
    end
  end

  def create
    @internal_code = InternalCode.new internal_code_attributes
    if @internal_code.save
      flash[:success] = 'Código interno salvo com sucesso.'
      redirect_to workflow_path(@internal_code.attendance)
    else
      unless @internal_code.errors.empty?
        flash[:warning] = @internal_code.errors.first.last
      else
        flash[:warning] = 'Erro ao cadastrar código interno, tente novamente mais tarde.'
      end
      unless @internal_code.sample.nil?
        redirect_to new_internal_code_path(@internal_code.sample, target: "sample")
        @fields = [Field.find_by({name: 'Imunofenotipagem'})]
      else
        redirect_to new_internal_code_path(@internal_code.subsample, target: "subsample")
        @fields = [Field.find_by({name: 'Biologia Molecular'}),Field.find_by({name: 'FISH'})]
      end
    end
  end

  def destroy
    internal_code = InternalCode.includes(:attendance).find params[:id]
    sample = internal_code.sample
    if internal_code.delete
      flash[:success] = 'Código interno removido com sucesso.'
      redirect_to workflow_path(internal_code.attendance)
    else
      flash[:warning] = 'Erro ao remover código interno, tente novamente mais tarde.'
      redirect_to workflow_path(internal_code.sample.attendance)
    end
  end

  private

  def internal_code_attributes
    params.require(:internal_code).permit(:sample_id, :field_id, :subsample_id)
  end

end
