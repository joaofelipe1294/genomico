class AddUsesSubsampleToExam < ActiveRecord::Migration[5.2]
  def change
  	add_column :exams, :uses_subsample, :boolean
  end
end
