class ChangeSubSampleKindsName < ActiveRecord::Migration
  def change
  	rename_table :sub_sample_kinds, :subsample_kinds
  end
end
