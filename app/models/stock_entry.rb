class StockEntry < ApplicationRecord
  belongs_to :reagent
  belongs_to :current_state
  belongs_to :responsible, class_name: :User
  validates :reagent, :lot, :entry_date, :current_state, :location, :responsible, presence: true
  validates_with StockEntryShelfDateValidator
  before_validation :generate_default_values

  private

    def generate_default_values
      return if self.shelf_life.nil?
      if self.has_shelf_life
        if self.shelf_life < Date.current
          self.is_expired = true
        else
          self.is_expired = false
        end
      else
        self.is_expired = false
      end
    end

end
