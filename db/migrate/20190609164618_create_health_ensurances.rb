class CreateHealthEnsurances < ActiveRecord::Migration
  def change
    create_table :health_ensurances do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
