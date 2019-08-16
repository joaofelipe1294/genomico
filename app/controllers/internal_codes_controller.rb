class InternalCodesController < ApplicationController


  def new
    @fields = [Field.find_by({name: 'Imunofenotipagem'})]
    @internal_code = InternalCode.new(sample: Sample.find(params[:id]))
  end




end
