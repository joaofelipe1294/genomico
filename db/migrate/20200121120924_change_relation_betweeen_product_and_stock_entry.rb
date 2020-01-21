class ChangeRelationBetweeenProductAndStockEntry < ActiveRecord::Migration[5.2]
  def change
    remove_reference :stock_entries, :product
    add_column :stock_entries, :product_amount, :int

    StockEntry.all.each { |stock_entry| stock_entry.update(product_amount: 1) }

  end
end
