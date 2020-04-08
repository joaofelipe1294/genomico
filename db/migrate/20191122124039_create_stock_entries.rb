class CreateStockEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_entries do |t|
      #t.references :reagent, foreign_key: true
      t.string :lot
      t.date :shelf_life
      t.boolean :is_expired
      t.integer :amount
      t.date :entry_date
      t.references :current_state, foreign_key: true
      t.string :location
      t.references :responsible, foreign_key: { to_table: 'users' }
      t.string :tag

      t.timestamps
    end
  end
end
