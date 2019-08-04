class CreateHealthEnsurances < ActiveRecord::Migration[5.2]
  def change
    create_table :health_ensurances do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
