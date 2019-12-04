class StockProduct < ApplicationRecord
  belongs_to :unit_of_measurement
  belongs_to :field
end
