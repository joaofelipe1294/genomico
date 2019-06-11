class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.references :offered_exam, index: true, foreign_key: true
      t.date :start_date
      t.date :finish_date
      t.references :exam_status_kind, index: true, foreign_key: true
      t.references :attendance, index: true, foreign_key: true
      t.references :sample, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
