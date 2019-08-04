class CreateOfferedExams < ActiveRecord::Migration[5.2]
  def change
    create_table :offered_exams do |t|
      t.string :name
      t.references :field, index: true, foreign_key: true
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
