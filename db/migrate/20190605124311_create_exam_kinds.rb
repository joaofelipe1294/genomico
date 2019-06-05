class CreateExamKinds < ActiveRecord::Migration
  def change
    create_table :exam_kinds do |t|
      t.string :name
      t.references :field, index: true, foreign_key: true
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
