class CreateSubSampleKinds < ActiveRecord::Migration
  def change
    create_table :sub_sample_kinds do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
