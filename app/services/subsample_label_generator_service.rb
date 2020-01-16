class SubsampleLabelGeneratorService

  def initialize subsample
    @subsample_kind = subsample.subsample_kind
  end

  def call
    index = curren_subsample_index + subsample_refference_value
    "#{Date.today.year.to_s.slice(2, 3)}-#{@subsample_kind.acronym}-#{index.to_s.rjust(4,  "0")}"
  end

  private

    def curren_subsample_index
      Subsample
              .where(subsample_kind: @subsample_kind)
              .size
    end

    def subsample_refference_value
      return 828 if @subsample_kind == SubsampleKind.VIRAL_DNA
      return 311 if @subsample_kind == SubsampleKind.RNA
      return 419 if @subsample_kind == SubsampleKind.DNA
      return 226 if @subsample_kind == SubsampleKind.PELLET
    end

end
