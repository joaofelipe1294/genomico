class DropUnitsOfMesasurement < ActiveRecord::Migration[5.2]
  def change
    add_column :stock_products, :unit_of_measurement, :integer
    #StockProduct.all.each { |stock_product| stock_product.update(unit_of_measurement: stock_product.unit_of_measurement_id) }
    #remove_column :stock_products, :unit_of_measurement_id
    #drop_table :unit_of_measurements
  end
end
