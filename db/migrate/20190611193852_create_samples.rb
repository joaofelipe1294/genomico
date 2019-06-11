class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.references :sample_kind, index: true, foreign_key: true
      t.boolean :has_sub_sample
      t.date :entry_date
      t.date :collection_date
      t.string :refference_label
      t.integer :bottles_numes
      t.references :attendance, index: true, foreign_key: true
      t.string :storage_location

      t.timestamps null: false
    end
  end
end
