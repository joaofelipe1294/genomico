class CurrentState < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  def self.STOCK
    CurrentState.find_by name: "Estoque"
  end

  def self.IN_USE
    CurrentState.find_by name: "Em uso"
  end

end
