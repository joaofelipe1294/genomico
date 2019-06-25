class Hospital < ActiveRecord::Base
  # belongs_to :patient
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :patients 
end
