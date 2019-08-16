class InternalCodesController < ApplicationController

  def new
    @fields = [Field.find_by({name: 'Imunofenotipagem'})]
    @internal_code = InternalCode.new(sample: Sample.find(params[:id]))
  end

  def create
    @internal_code = InternalCode.new internal_code_attributes
    if @internal_code.save
      flash[:success] = 'Código interno salvo com sucesso.'
      redirect_to new_internal_code_path(@internal_code.sample.id)
    else
      flash[:error] = 'Erro ao cadastrar código interno, tente novamente mais tarde.'
      @fields = [Field.find_by({name: 'Imunofenotipagem'})]
      render @internal_code
    end
  end

  def destroy
    internal_code = InternalCode.find params[:id]
    sample = internal_code.sample
    if internal_code.delete
      flash[:success] = 'Código interno removido com sucesso.'
      redirect_to new_internal_code_path(sample.id)
    else
      flash[:error] = 'Erro ao remover código interno, tente novamente mais tarde.'
      redirect_to workflow_path(internal_code.sample.attendance)
    end
  end

  private

  def internal_code_attributes
    params.require(:internal_code).permit(:sample_id, :field_id)
  end

end
