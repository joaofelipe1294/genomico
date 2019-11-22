class CreateCurrentStates < ActiveRecord::Migration[5.2]
  def change
    create_table :current_states do |t|
      t.string :name

      t.timestamps
    end
    CurrentState.create([{name: "Estoque"}, {name: "Em uso"}])
  end
end
