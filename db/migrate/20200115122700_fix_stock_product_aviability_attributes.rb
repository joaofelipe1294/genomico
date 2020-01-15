class FixStockProductAviabilityAttributes < ActiveRecord::Migration[5.2]
  def change
    change_column :stock_products, :total_aviable, :float
    add_column :stock_products, :total_in_use, :float
  end
end
