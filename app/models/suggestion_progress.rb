class SuggestionProgress < ApplicationRecord
  belongs_to :suggestion
  belongs_to :responsible, class_name: :User
  enum current_status: statuses()
end
