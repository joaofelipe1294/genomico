class AddUnitsOfMeaserametRequested < ActiveRecord::Migration[5.2]
  def change
    UnitOfMeasurement.create([
      {name: "Teste"},
      {name: "Separação"},
      {name: "Mililitros"},
      {name: "Litro"},
      {name: "Grama"},
      {name: "Miligrama"},
      {name: "Tubo"},
    ])
  end
end
