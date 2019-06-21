class AddAcronymColumnToSubsampleKind < ActiveRecord::Migration
  def change
  	add_column :subsample_kinds, :acronym, :string
  end
end
