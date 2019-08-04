class CreateNanodropReports < ActiveRecord::Migration[5.2]
  def change
    create_table :nanodrop_reports do |t|
      t.float :concentration
      t.float :rate_260_280
      t.float :rate_260_230
      t.references :subsample, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
