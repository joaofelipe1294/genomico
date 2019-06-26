class CreateWorkMaps < ActiveRecord::Migration
  def change
    create_table :work_maps do |t|
      t.datetime :data

      t.timestamps null: false
    end
  end
end
