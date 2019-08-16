class CreateInternalCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :internal_codes do |t|
      t.integer :code
      t.references :field, foreign_key: true

      t.timestamps
    end
  end
end
