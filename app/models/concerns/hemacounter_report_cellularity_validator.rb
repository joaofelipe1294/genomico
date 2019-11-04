class HemacounterReportCellularityValidator < ActiveModel::Validator

  def validate record
    if record.cellularity < 0
      record.errors[:cellularity] << "não pode ser menor do que zero"
    end
  end

end
