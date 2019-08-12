class AddRefferenceDateToOfferedExam < ActiveRecord::Migration[5.2]

  def change
    add_column :offered_exams, :refference_date, :int
  end
  
end
