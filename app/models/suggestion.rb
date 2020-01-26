class Suggestion < ApplicationRecord
  belongs_to :requester, class_name: User
end
