class CreateAttendancesWorkMaps < ActiveRecord::Migration
  def change
    create_table :attendances_work_maps do |t|
    	t.belongs_to :attendance, index: true
      t.belongs_to :work_map, index: true
    end
  end
end
