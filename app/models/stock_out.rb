class StockOut < ApplicationRecord
  belongs_to :stock_product
  belongs_to :product
  belongs_to :responsible, class_name: :User
end
