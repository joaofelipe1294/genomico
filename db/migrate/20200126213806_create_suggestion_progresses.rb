class CreateSuggestionProgresses < ActiveRecord::Migration[5.2]
  def change
    create_table :suggestion_progresses do |t|
      t.references :suggestion, foreign_key: true
      t.references :responsible, foreign_key: { to_table: "users" }
      t.string :old_status
      t.string :new_status

      t.timestamps
    end
  end
end
