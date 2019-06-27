class AddReferenceFromAttendanceToSubsample < ActiveRecord::Migration
  def change
  	add_reference :subsamples, :attendance, index: true
  end
end
