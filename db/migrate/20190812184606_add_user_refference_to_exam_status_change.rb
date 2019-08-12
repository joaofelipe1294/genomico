class AddUserRefferenceToExamStatusChange < ActiveRecord::Migration[5.2]
  def change
    add_reference :exam_status_changes, :user, index: true
  end
end
