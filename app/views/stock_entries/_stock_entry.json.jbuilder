json.extract! stock_entry, :id, :reagent_id, :lot, :shelf_life, :is_expired, :amount, :entry_date, :current_state_id, :location, :user_id, :tag, :created_at, :updated_at
json.url stock_entry_url(stock_entry, format: :json)
