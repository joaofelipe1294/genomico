class CreateTableSamplesWorkMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :samples_work_maps do |t|
    	t.belongs_to :sample, index: true
      t.belongs_to :work_map, index: true
    end
  end
end
