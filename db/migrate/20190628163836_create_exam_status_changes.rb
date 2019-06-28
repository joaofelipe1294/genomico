class CreateExamStatusChanges < ActiveRecord::Migration
  def change
    create_table :exam_status_changes do |t|
      t.references :exam, index: true, foreign_key: true
      t.references :exam_status_kind, index: true, foreign_key: true
      t.datetime :change_date

      t.timestamps null: false
    end
  end
end
