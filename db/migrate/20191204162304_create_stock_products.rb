class CreateStockProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_products do |t|
      t.string :name
      t.integer :usage_per_test
      t.integer :total_aviable
      t.integer :first_warn_at
      t.integer :danger_warn_at
      t.string :mv_code
      #t.references :unit_of_measurement, foreign_key: true
      t.references :field, foreign_key: true
      t.boolean :is_shared

      t.timestamps
    end
  end
end
