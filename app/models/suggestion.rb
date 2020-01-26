class Suggestion < ApplicationRecord
  belongs_to :requester, class_name: :User
  validates_presence_of :title, :description, :requester
  validates_uniqueness_of :title
end
