class AddObsevationToSubsample < ActiveRecord::Migration[5.2]
  def change
    add_column :subsamples, :observations, :string 
  end
end
