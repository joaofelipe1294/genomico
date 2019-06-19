class CreateNanodropData < ActiveRecord::Migration
  def change
    create_table :nanodrop_data do |t|
      t.references :subsample, index: true, foreign_key: true
      t.float :concentration
      t.float :rate_260_280
      t.float :rate_260_230

      t.timestamps null: false
    end
  end
end
