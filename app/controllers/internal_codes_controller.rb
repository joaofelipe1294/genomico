class InternalCodesController < ApplicationController

  def new
    @fields = [Field.find_by({name: 'Imunofenotipagem'})]
    @internal_code = InternalCode.new(sample: Sample.find(params[:id]))
  end

  def create
    @internal_code = InternalCode.new internal_code_attributes
    if @internal_code.save
      flash[:success] = 'Código interno salvo com sucesso.'
    else
      flash[:error] = 'Erro ao cadastrar código interno, tente novamente mais tarde.'
    end
  end

  private

  def internal_code_attributes
    params.require(:internal_code).permit(:sample_id, :field_id)
  end

end
