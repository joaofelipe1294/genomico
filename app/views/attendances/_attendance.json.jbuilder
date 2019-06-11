json.extract! attendance, :id, :desease_stage_id, :cid_code, :lis_code, :start_date, :finish_date, :patient_id, :attendance_status_kind_id, :doctor_name, :doctor_crm, :observations, :health_ensurance_id, :created_at, :updated_at
json.url attendance_url(attendance, format: :json)
