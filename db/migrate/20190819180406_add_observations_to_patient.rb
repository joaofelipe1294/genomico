class AddObservationsToPatient < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :observations, :text
  end
end
