class Product < ApplicationRecord
  belongs_to :reagent
  belongs_to :current_state
  belongs_to :stock_entry
end
