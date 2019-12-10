class ChangeStockEntriesModel < ActiveRecord::Migration[5.2]
  def change
    StockEntry.all.each do |stock_entry|
      Product.create({
        reagent_id: stock_entry.reagent_id,
        lot: stock_entry.lot,
        shelf_life: stock_entry.shelf_life,
        is_expired: stock_entry.is_expired,
        amount: stock_entry.amount,
        current_state_id: stock_entry.current_state_id,
        location: stock_entry.location,
        tag: stock_entry.tag,
        has_shelf_life: stock_entry.has_shelf_life,
        has_tag: stock_entry.has_tag,
        brand: stock_entry.reagent.brand,
        stock_entry: stock_entry
      })
    end
    # remove_reference :stock_entries, :reagent
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
