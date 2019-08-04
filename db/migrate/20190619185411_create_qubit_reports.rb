class CreateQubitReports < ActiveRecord::Migration[5.2]
  def change
    create_table :qubit_reports do |t|
      t.float :concentration
      t.references :subsample, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
