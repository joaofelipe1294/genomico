class CreateUnitOfMeasurements < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_of_measurements do |t|
      t.string :name

      t.timestamps
    end

    UnitOfMeasurement.create([
      { name: "Caixas"} ,
      { name: "Microlitros"} ,
      { name: "Unidades"} ,
      { name: "Kits"} ,
      { name: "Reações"} ,
      { name: "Extrações"} ,
    ])

  end
  
end
