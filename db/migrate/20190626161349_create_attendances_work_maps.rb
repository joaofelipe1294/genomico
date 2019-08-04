class CreateAttendancesWorkMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances_work_maps do |t|
    	t.belongs_to :attendance, index: true
      t.belongs_to :work_map, index: true
    end
  end
end
