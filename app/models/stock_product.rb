class StockProduct < ApplicationRecord
  belongs_to :unit_of_measurement
  belongs_to :field
  validates :name, :total_aviable, presence: true
  validates :name, uniqueness: true
  before_validation :set_total_aviable
  validates_with StockProductMvCodeUniquenessValidator
  paginates_per 15

  def display_field
    if self.field
      content = self.field.name
    else
      content = "Compartilhado"
    end
    "<label>#{content}</label>".html_safe
  end

  private

    def set_total_aviable
      self.total_aviable = 0 unless self.total_aviable
    end

end
