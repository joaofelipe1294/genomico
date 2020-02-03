class MigrateOfferedExamGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :offered_exams, :group, :integer
    OfferedExam.all.each { |offered_exam| offered_exam.update group: offered_exam.offered_exam_group_id }
    remove_reference :offered_exams, :offered_exam_group
    drop_table :offered_exam_groups
  end
end
