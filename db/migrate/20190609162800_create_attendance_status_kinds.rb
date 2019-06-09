class CreateAttendanceStatusKinds < ActiveRecord::Migration
  def change
    create_table :attendance_status_kinds do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
