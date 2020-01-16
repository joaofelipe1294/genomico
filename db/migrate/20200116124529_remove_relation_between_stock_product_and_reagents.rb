class RemoveRelationBetweenStockProductAndReagents < ActiveRecord::Migration[5.2]
  def change
    remove_reference :stock_products, :reagent
  end
end
