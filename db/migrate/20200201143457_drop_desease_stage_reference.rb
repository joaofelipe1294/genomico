class DropDeseaseStageReference < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :desease_stage, :integer
    #Attendance.all.each { |attendance| attendance.update(desease_stage: attendance.desease_stage_id) }
    #remove_reference :attendances, :desease_stage
    #drop_table :desease_stages
  end
end
