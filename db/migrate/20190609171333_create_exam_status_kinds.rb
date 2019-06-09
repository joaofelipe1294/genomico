class CreateExamStatusKinds < ActiveRecord::Migration
  def change
    create_table :exam_status_kinds do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
