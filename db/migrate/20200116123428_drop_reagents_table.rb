class DropReagentsTable < ActiveRecord::Migration[5.2]
  def change
    remove_reference :stock_entries, :reagent
    remove_reference :products, :reagent
    drop_table :reagents
  end
end
