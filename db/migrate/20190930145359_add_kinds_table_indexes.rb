class AddKindsTableIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index(:subsample_kinds, :name)
    add_index(:sample_kinds, :name)
    add_index(:attendance_status_kinds, :name)
    add_index(:exam_status_kinds, :name)
    add_index(:fields, :name)
    add_index(:user_kinds, :name)
  end
end
