class SetAllTotalAviableAndTotalInUseTo0 < ActiveRecord::Migration[5.2]
  def change

    StockProduct.all.each do |stock_product|
      stock_product.update({total_aviable: 0, total_in_use: 0})
    end

  end
end
