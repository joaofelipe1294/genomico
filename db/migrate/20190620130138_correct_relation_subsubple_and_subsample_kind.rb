class CorrectRelationSubsubpleAndSubsampleKind < ActiveRecord::Migration
  def change
  	rename_column :subsamples, :sub_sample_kind_id, :subsample_kind_id
  end
end
