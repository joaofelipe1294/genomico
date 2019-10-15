class AddUnitOfMeasurementReferenceToReagentsTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :reagents, :unit_of_measurement, foreign_key: true
  end
end
