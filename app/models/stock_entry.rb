class StockEntry < ApplicationRecord
  belongs_to :reagent
  belongs_to :current_state
  belongs_to :responsible, class_name: :User
  validates :reagent, :lot, :entry_date, :current_state, :location, :responsible, presence: true
  validates_with StockEntryShelfDateValidator
end
