class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.string :name
      t.date :birth_date
      t.string :mother_name
      t.string :medical_record

      t.timestamps null: false
    end
  end
end
