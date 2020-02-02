class StockProduct < ApplicationRecord
  belongs_to :field
  validates_presence_of :name, :unit_of_measurement
  validates_uniqueness_of :name
  before_validation :set_shared_field
  validates_with StockProductMvCodeUniquenessValidator
  paginates_per 15
  has_many :products

  enum unit_of_measurement: {
    boxes: 1,
    microliters: 2,
    unities: 3,
    kits: 4,
    reactions: 5,
    extractions: 6,
    tests: 7,
    separations: 8,
    mililiters: 9,
    liters: 10,
    gram: 11,
    miligram: 12,
    pipe: 13,
    bottle: 14,
    package: 15
  }

  def self.unit_of_measurements_for_select
    list = unit_of_measurements.map do |unit_of_measurement, _|
      [ I18n.t("enums.stock_product.units_of_measurement.#{unit_of_measurement}"), unit_of_measurement ]
    end
    list.sort
  end

  def desease_stage_name
    I18n.t("enums.stock_product.units_of_measurement.#{self.unit_of_measurement}")
  end

  def self.products_base_report
    StockProduct.includes(:unit_of_measurement).all.order(:name).select do |stock_product|
      stock_product
                  .products
                  .where("products.current_state_id = ? OR products.current_state_id = ?", CurrentState.STOCK.id, CurrentState.IN_USE.id)
                  .size > 0
    end
  end

  def total_in_use
    self.products.where(current_state: CurrentState.IN_USE).sum("products.amount")
  end

  def total_aviable
    self.products.where(current_state: CurrentState.STOCK).sum("products.amount")
  end

  private

    def set_shared_field
      self.field = nil if self.is_shared
    end

end
