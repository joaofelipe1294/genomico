class AddReferenceFromAttendanceToSubsample < ActiveRecord::Migration[5.2]
  def change
  	add_reference :subsamples, :attendance, index: true
  end
end
