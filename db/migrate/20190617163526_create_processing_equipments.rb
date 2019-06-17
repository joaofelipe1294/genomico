class CreateProcessingEquipments < ActiveRecord::Migration
  def change
    create_table :processing_equipments do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
