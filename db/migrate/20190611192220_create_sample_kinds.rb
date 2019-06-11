class CreateSampleKinds < ActiveRecord::Migration
  def change
    create_table :sample_kinds do |t|
      t.string :name
      t.string :acronym

      t.timestamps null: false
    end
  end
end
