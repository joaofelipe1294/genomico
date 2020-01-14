class Brand < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  paginates_per 14
end
