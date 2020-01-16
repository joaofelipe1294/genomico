class InternalCodeGeneratorService

  def initialize internal_code
    @sample = internal_code.sample
    @subsample = internal_code.subsample
    @field = internal_code.field
    @current_date = Date.current
  end


  def call
    if @field == Field.IMUNOFENO
      imunofeno_internal_code
    elsif @field == Field.BIOMOL && @subsample
      @subsample.refference_label
    elsif @field == Field.FISH && @subsample
      @subsample.refference_label
    else
      InternalCode.where(field: @field).size + 1
    end
  end

  private

    def imunofeno_internal_code
      start_date = @current_date.beginning_of_year
      finish_date = @current_date.end_of_year
      new_code = InternalCode
                                  .joins(:sample)
                                  .where(field: @field)
                                  .where("samples.collection_date BETWEEN ? AND ?", start_date, finish_date)
                                  .size + 1
      # new_code = internal_codes + 1
      # puts "---------------------------"
      # p InternalCode.all
      # p InternalCode.all.size
      # p InternalCode.joins(:sample).where(field: @field).where("samples.collection_date BETWEEN ? AND ?", start_date, finish_date)
      # puts "Indice: #{internal_codes}"
      # puts "Novo codigo: #{new_code}"
      # puts "Field: #{Field.IMUNOFENO.id}"
      # puts "---------------------------"
      "#{@current_date.year.to_s.slice(2, 3)}#{new_code.to_s.rjust(4,  "0")}"
    end

end
