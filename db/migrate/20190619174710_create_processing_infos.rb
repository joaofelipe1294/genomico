class CreateProcessingInfos < ActiveRecord::Migration
  def change
    create_table :processing_infos do |t|
      t.references :subsample, index: true, foreign_key: true
      t.float :concentration
      t.float :rate_260_280
      t.float :rate_260_230
      t.references :processing_equipment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
