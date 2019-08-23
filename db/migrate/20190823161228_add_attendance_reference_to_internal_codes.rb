class AddAttendanceReferenceToInternalCodes < ActiveRecord::Migration[5.2]
  def change
    add_reference :internal_codes, :attendance
  end
end
