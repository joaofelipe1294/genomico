class DropSamplesWorkMapsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :samples_work_maps
  end
end
