class Hospital < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :patients

  def self.HPP
    Hospital.find_by name: 'Hospital Pequeno Príncipe'
  end
  
end
