class AddCompleteStatusToCurrentState < ActiveRecord::Migration[5.2]
  def change
    CurrentState.create(name: "Concluído")
  end
end
