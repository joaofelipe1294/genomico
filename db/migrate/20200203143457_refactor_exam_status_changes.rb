class RefactorExamStatusChanges < ActiveRecord::Migration[5.2]
  def change
    add_column :exam_status_changes, :new_status, :string
    ExamStatusChange.all.each do |change|
      change.new_status = :progress if change.exam_status_kind_id  == 1
      change.new_status = :tecnical_released if change.exam_status_kind_id  == 2
      change.new_status = :in_repeat if change.exam_status_kind_id  == 3
      change.new_status = :complete if change.exam_status_kind_id  == 4
      change.new_status = :waiting_start if change.exam_status_kind_id  == 5
      change.new_status = :partial_released if change.exam_status_kind_id  == 6
      change.new_status = :complete_without_report if change.exam_status_kind_id  == 7
      change.new_status = :canceled if change.exam_status_kind_id  == 8
      change.save
    end
    remove_column :exam_status_changes, :exam_status_kind_id
  end
end
