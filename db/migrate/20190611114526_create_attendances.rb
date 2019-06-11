class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :desease_stage, index: true, foreign_key: true
      t.string :cid_code
      t.string :lis_code
      t.datetime :start_date
      t.datetime :finish_date
      t.references :patient, index: true, foreign_key: true
      t.references :attendance_status_kind, index: true, foreign_key: true
      t.string :doctor_name
      t.string :doctor_crm
      t.string :observations
      t.references :health_ensurance, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
