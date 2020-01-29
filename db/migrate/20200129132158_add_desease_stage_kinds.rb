class AddDeseaseStageKinds < ActiveRecord::Migration[5.2]
  def change
    DeseaseStage.create([
      {name: "Subpopulação"},
      {name: "Subpopulação com RET"},
      {name: "Perfil Imune"},
      ])
  end
end
