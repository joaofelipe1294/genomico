class AddTablesIndexes < ActiveRecord::Migration[5.2]
  def change
    #add_index :attendance_status_kinds, :id
    #add_index :desease_stages, :id
    add_index :health_ensurances, :id
    add_index :exams, :id
    add_index :attendances, :id
    add_index :hospitals, :id
    add_index :patients, :id
    add_index :patients, :name
    add_index :patients, :medical_record
    add_index :subsamples, :id
    add_index :subsample_kinds, :id
    add_index :qubit_reports, :id
    add_index :nanodrop_reports, :id
    add_index :samples, :id
    add_index :sample_kinds, :id
    add_index :internal_codes, :id
    add_index :offered_exams, :id
    add_index :fields, :id
    #add_index :exam_status_kinds, :id
    add_index :users, :id
    #add_index :user_kinds, :id
    add_index :work_maps, :id
  end
end
