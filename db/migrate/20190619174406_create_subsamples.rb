class CreateSubsamples < ActiveRecord::Migration
  def change
    create_table :subsamples do |t|
      t.references :sample, index: true, foreign_key: true
      t.string :refference_label
      t.string :storage_location
      t.references :sub_sample_kind, index: true, foreign_key: true
      t.datetime :collection_date

      t.timestamps null: false
    end
  end
end
