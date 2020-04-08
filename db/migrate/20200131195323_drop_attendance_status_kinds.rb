class DropAttendanceStatusKinds < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :status, :integer
    #Attendance.all.each { |attendance| attendance.update(status: attendance.attendance_status_kind_id) }
    #remove_column :attendances, :attendance_status_kind_id
    #drop_table :attendance_status_kinds
  end
end
