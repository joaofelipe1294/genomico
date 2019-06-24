class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.references :patient, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
