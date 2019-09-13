class DropSubsamplesWorkMapsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :subsamples_work_maps
  end
end
