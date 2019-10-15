class CreateBottleStatusKinds < ActiveRecord::Migration[5.2]
  def up
    create_table :bottle_status_kinds do |t|
      t.string :name

      t.timestamps
    end

    BottleStatusKind.create([
      {name: "Em estoque"},
      {name: "Em uso"},
      {name: "Em quarentena"},
    ])

  end

end
