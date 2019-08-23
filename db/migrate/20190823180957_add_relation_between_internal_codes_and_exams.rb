class AddRelationBetweenInternalCodesAndExams < ActiveRecord::Migration[5.2]
  def change
    add_reference :exams, :internal_code
    add_reference :internal_codes, :subsample
    remove_column :exams, :sample_id
    remove_column :exams, :subsample_id
    remove_column :exams, :uses_subsample
  end
end
