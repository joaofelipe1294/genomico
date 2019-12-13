class MigrateReagentsToStockProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :stock_product
    add_reference :stock_entries, :stock_product

    StockEntry.all.each do |stock_entry|

      product = Product.create({
        stock_product_id: stock_entry.reagent_id,
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

      p "Produto é valido: #{product.valid?}"
      stock_entry.stock_product = StockProduct.find stock_entry.reagent.id
      stock_entry.product = product
      p stock_entry.stock_product
      stock_entry.save
      p stock_entry.errors
    end
  end
end
