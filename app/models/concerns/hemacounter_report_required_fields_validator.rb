class HemacounterReportRequiredFieldsValidator < ActiveModel::Validator

  def validate record
    return unless record.subsample
    if record.subsample.subsample_kind == SubsampleKind.RNA
      record.errors[:leukocyte_total_count] << "não pode ficar em branco" unless record.leukocyte_total_count
      record.errors[:volume] << "não pode ficar em branco" unless record.volume
      record.errors[:cellularity] << "não pode ficar em branco" unless record.cellularity
    end
  end

end
