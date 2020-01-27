class SuggestionProgress < ApplicationRecord
  belongs_to :suggestion
  belongs_to :responsible, class_name: :User
  validates_presence_of :new_status, :suggestion
end
