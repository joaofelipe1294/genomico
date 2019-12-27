class CreateStockOuts < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_outs do |t|
      t.references :stock_product, foreign_key: true
      t.references :product, foreign_key: true
      t.date :date
      t.references :responsible, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
