class AddDelayAttributeToExams < ActiveRecord::Migration[5.2]
  def change
    add_column :exams, :was_delayed, :boolean
    add_column :exams, :lag_time, :integer
  end
end
