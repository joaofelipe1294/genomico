class ChangeSubSampleKindsName < ActiveRecord::Migration[5.2]
  def change
  	rename_table :sub_sample_kinds, :subsample_kinds
  end
end
