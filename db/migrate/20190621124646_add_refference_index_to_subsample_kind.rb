class AddRefferenceIndexToSubsampleKind < ActiveRecord::Migration
  def change
  	add_column :subsample_kinds, :refference_index, :integer
  end
end
