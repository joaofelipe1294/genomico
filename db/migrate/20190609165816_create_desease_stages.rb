class CreateDeseaseStages < ActiveRecord::Migration
  def change
    create_table :desease_stages do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
