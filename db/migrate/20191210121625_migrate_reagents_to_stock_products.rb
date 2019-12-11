class MigrateReagentsToStockProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :stock_product
    add_reference :stock_entries, :stock_product

    StockEntry.all.each do |stock_entry|
      stock_entry.stock_product = StockProduct.find_by name: stock_entry.reagent.name
      p stock_entry.stock_product
      stock_entry.save
      p stock_entry.errors
    end
  end
end
