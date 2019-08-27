class RenameSubsamplesInternalCodes < ActiveRecord::Migration[5.2]
  def change
    rename_column :internal_codes, :subsampl_id, :subsample_id
  end
end
