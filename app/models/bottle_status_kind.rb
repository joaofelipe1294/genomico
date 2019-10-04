class BottleStatusKind < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, presence: true

  def self.IN_STOCK
    BottleStatusKind.find_by name: 'Em estoque'
  end

  def self.IN_USE
    BottleStatusKind.find_by name: 'Em uso'
  end

  def self.IN_QUARENTINE
    BottleStatusKind.find_by name: 'Em quarentena'
  end

end
