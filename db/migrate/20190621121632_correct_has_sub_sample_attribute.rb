class CorrectHasSubSampleAttribute < ActiveRecord::Migration[5.2]
  def change
  	rename_column :samples, :has_sub_sample, :has_subsample
  end
end
