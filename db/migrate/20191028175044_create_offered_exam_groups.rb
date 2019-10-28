class CreateOfferedExamGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :offered_exam_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
