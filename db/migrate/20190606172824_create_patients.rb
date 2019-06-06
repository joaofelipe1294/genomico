class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.date :birth_date
      t.string :mother_name
      t.integer :medical_record

      t.timestamps null: false
    end
  end
end
