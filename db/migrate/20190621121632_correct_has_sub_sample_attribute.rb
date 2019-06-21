class CorrectHasSubSampleAttribute < ActiveRecord::Migration
  def change
  	rename_column :samples, :has_sub_sample, :has_subsample
  end
end
