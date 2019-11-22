class StockEntry < ApplicationRecord
  belongs_to :reagent
  belongs_to :current_state
  belongs_to :user
end
