class AddExamStatusKindAsColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :exams, :status, :integer
    #Exam.all.each { |exam| exam.update status: exam.exam_status_kind_id }
    #remove_reference :exams, :exam_status_kind
  end
end
