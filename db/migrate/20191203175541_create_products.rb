class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      #t.references :reagent, foreign_key: true
      t.string :lot
      t.date :shelf_life
      t.boolean :is_expired
      t.integer :amount
      t.references :current_state, foreign_key: true
      t.string :location
      t.string :tag
      t.boolean :has_shelf_life
      t.boolean :has_tag
      t.date :open_at
      t.date :finished_at
      t.references :stock_entry, foreign_key: true
      t.references :brand, foreign_key: true

      t.timestamps
    end
  end
end
