json.extract! release, :id, :name, :tag, :message, :is_actve, :created_at, :updated_at
json.url release_url(release, format: :json)
