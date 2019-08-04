class CreateWorkMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :work_maps do |t|
      t.date     :date
      t.string   :name

      t.timestamps null: false
    end
  end
end
