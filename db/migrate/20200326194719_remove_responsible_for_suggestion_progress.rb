class RemoveResponsibleForSuggestionProgress < ActiveRecord::Migration[5.2]
  def change
    remove_reference :suggestion_progresses, :responsible
  end
end
