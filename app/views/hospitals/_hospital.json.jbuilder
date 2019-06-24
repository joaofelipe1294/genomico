json.extract! hospital, :id, :patient_id, :name, :created_at, :updated_at
json.url hospital_url(hospital, format: :json)
