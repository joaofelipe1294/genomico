class SuggestionProgress < ApplicationRecord
  belongs_to :suggestion
  validates_presence_of :new_status, :suggestion
end
