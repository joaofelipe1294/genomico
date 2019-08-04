class CreateSubsamplesWorkMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :subsamples_work_maps do |t|
    	t.belongs_to :subsample, index: true
      t.belongs_to :work_map, index: true
    end
  end
end
