class RemoveNotUserAttributesFromStockProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :stock_products, :total_in_use
    remove_column :stock_products, :total_aviable
  end
end
