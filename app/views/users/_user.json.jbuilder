json.extract! user, :id, :login, :password_digest, :name, :is_active, :user_kind_id, :created_at, :updated_at
json.url user_url(user, format: :json)
