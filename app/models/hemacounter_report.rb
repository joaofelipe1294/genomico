class HemacounterReport < ApplicationRecord
  belongs_to :subsample
  before_validation :calc_cellularity
  validates :subsample, presence: true
  # validates_with HemacounterReportRequiredFieldsValidator
  validates_with HemacounterReportCellularityValidator

  private

  def calc_cellularity
    self.cellularity = self.volume * self.leukocyte_total_count if self.volume && self.leukocyte_total_count
  end

end
