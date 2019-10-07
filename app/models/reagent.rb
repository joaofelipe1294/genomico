class Reagent < ApplicationRecord
  belongs_to :field
  validates :product_description, :name, :brand, :mv_code, :product_code, presence: true
  before_validation :before_validation
  validates :product_description, :name, :mv_code, :product_code, uniqueness: true
  belongs_to :brand

  private

    def before_validation
      self.total_aviable = 0 unless self.total_aviable
      self.stock_itens = 0 unless self.stock_itens
    end

end
