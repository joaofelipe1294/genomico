class CreateReleases < ActiveRecord::Migration[5.2]
  def change
    create_table :releases do |t|
      t.string :name
      t.string :tag
      t.string :message
      t.boolean :is_actve

      t.timestamps
    end
  end
end
