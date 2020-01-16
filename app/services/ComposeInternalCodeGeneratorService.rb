class ComposeInternalCodeGeneratorService

  def initialize exam
    @attendance = exam.attendance
    @internal_code_ids = exam.internal_code_ids
    @internal_codes = exam.internal_codes
    @biomol_internal_codes = @attendance.internal_codes.where(field: Field.BIOMOL).joins(:subsample)
  end

  def call
    return nil unless @attendance
    if @internal_code_ids.empty? && @biomol_internal_codes.size >= 2
      @internal_codes << get_subsample(SubsampleKind.DNA)
      @internal_codes << get_subsample(SubsampleKind.RNA)
      @internal_codes
    end
  end

  private

    def get_subsample subsample_kind
      @biomol_internal_codes.where("subsamples.subsample_kind_id = ?", subsample_kind.id).first
    end

end
