class AddUsesSubsampleToExam < ActiveRecord::Migration
  def change
  	add_column :exams, :uses_subsample, :boolean
  end
end
