class CreateReagents < ActiveRecord::Migration[5.2]
  def change
    create_table :reagents do |t|
      t.string :product_description
      t.string :name
      t.integer :stock_itens
      t.integer :usage_per_test
      t.string :brand
      t.integer :total_aviable
      t.references :field, foreign_key: true
      t.integer :first_warn_at
      t.integer :danger_warn_at
      t.string :mv_code
      t.string :product_code

      t.timestamps
    end
  end
end
