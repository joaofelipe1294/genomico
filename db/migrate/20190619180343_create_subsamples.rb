class CreateSubsamples < ActiveRecord::Migration[5.2]
  def change
    create_table :subsamples do |t|
      t.string :storage_location
      t.string :refference_label
      t.references :sub_sample_kind, index: true, foreign_key: true
      t.references :sample, index: true, foreign_key: true
      t.datetime :collection_date

      t.timestamps null: false
    end
  end
end
