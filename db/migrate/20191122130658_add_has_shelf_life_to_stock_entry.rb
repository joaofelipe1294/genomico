class AddHasShelfLifeToStockEntry < ActiveRecord::Migration[5.2]
  def change
    add_column :stock_entries, :has_shelf_life, :boolean
  end
end
