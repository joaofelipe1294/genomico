class CreateSubSamples < ActiveRecord::Migration
  def change
    create_table :sub_samples do |t|
      t.string :storage_location
      t.float :concentration
      t.float :rate_260_280
      t.float :rate_260_230
      t.references :processing_equipment, index: true, foreign_key: true
      t.references :sub_sample_kind, index: true, foreign_key: true
      t.references :sample, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
