class AddAttributeHasTag < ActiveRecord::Migration[5.2]
  def change
    add_column :stock_entries, :has_tag, :boolean
  end
end
