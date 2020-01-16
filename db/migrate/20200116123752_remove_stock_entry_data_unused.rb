class RemoveStockEntryDataUnused < ActiveRecord::Migration[5.2]
  def change
    remove_column :stock_entries, :lot
    remove_column :stock_entries, :shelf_life
    remove_column :stock_entries, :is_expired
    remove_column :stock_entries, :amount
    remove_reference :stock_entries, :current_state
    remove_column :stock_entries, :location
    remove_column :stock_entries, :tag
    remove_column :stock_entries, :has_shelf_life
    remove_column :stock_entries, :has_tag
  end
end
