class AddRefferenceIndexToSubsampleKind < ActiveRecord::Migration[5.2]
  def change
  	add_column :subsample_kinds, :refference_index, :integer
  end
end
