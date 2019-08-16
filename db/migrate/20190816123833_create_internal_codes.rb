class CreateInternalCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :internal_codes do |t|
      t.references :sample, foreign_key: true
      t.references :field, foreign_key: true
      t.string :code 

      t.timestamps
    end
  end
end
