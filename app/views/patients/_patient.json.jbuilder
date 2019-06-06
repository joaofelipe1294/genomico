json.extract! patient, :id, :name, :birth_date, :mother_name, :medical_record, :created_at, :updated_at
json.url patient_url(patient, format: :json)
