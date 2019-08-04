class AddAcronymColumnToSubsampleKind < ActiveRecord::Migration[5.2]
  def change
  	add_column :subsample_kinds, :acronym, :string
  end
end
