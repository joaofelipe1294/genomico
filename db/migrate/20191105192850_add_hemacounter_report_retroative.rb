class AddHemacounterReportRetroative < ActiveRecord::Migration[5.2]
  def change
    Subsample.all.each do |subsample|
        subsample.hemacounter_report = HemacounterReport.new
        subsample.save
    end
  end
end
