class DropUsagePerTestAndChangeWarningTypes < ActiveRecord::Migration[5.2]
  def change
    remove_column :stock_products, :usage_per_test
    change_column :stock_products, :first_warn_at, :float
    change_column :stock_products, :danger_warn_at, :float
  end
end
