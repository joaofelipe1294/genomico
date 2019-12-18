class AddProductStockEntryRelation < ActiveRecord::Migration[5.2]
  def change
    add_reference :stock_entries, :product
  end
end
