class CreateFields < ActiveRecord::Migration[5.2]
  def change
    create_table :fields do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
