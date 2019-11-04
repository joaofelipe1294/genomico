class CreateHemacounterReports < ActiveRecord::Migration[5.2]
  def change
    create_table :hemacounter_reports do |t|
      t.references :subsample, foreign_key: true
      t.float :valume
      t.float :leukocyte_total_count
      t.float :cellularity
      t.float :pellet_leukocyte_count

      t.timestamps
    end
  end
end
