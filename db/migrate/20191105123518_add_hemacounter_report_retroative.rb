class AddHemacounterReportRetroative < ActiveRecord::Migration[5.2]
  def change
    Subsample.all.each do |subsample|
      puts "================================================"
      p subsample
      if subsample.subsample_kind == SubsampleKind.DNA || subsample.subsample_kind == SubsampleKind.RNA
        puts "--- DNA ou RNA"
        subsample.hemacounter_report = HemacounterReport.new({
          leukocyte_total_count: 0,
          volume: 0,
          pellet_leukocyte_count: 0,
          cellularity: 0
          })
        subsample.save
      else
        puts "--- NAO DNA e RNA"
        subsample.hemacounter_report = HemacounterReport.new
        subsample.save
      end
      puts "================================================"
    end
  end
end
