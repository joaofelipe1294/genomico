class Reagent < ApplicationRecord
  belongs_to :field
  validates :product_description, :name, :brand, :product_code, :unit_of_measurement, presence: true
  before_validation :before_validation
  validates :product_description, :name, :product_code, uniqueness: true
  belongs_to :brand
  paginates_per 15
  validates_with ReagentMvCodeUniquenessValidator
  belongs_to :unit_of_measurement

  def display_field
    if self.field
      content = self.field.name
    else
      content = "Compartilhado"
    end
    "<label>#{content}</label>".html_safe
  end

  private

    def before_validation
      self.total_aviable = 0 unless self.total_aviable
      self.stock_itens = 0 unless self.stock_itens
    end

end
