json.extract! stock_product, :id, :name, :usage_per_test, :total_aviable, :first_warn_at, :danger_warn_at, :mv_code, :unit_of_measurement_id, :field_id, :is_shared, :created_at, :updated_at
json.url stock_product_url(stock_product, format: :json)
