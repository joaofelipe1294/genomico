class CreateSuggestions < ActiveRecord::Migration[5.2]
  def change
    create_table :suggestions do |t|
      t.string :title
      t.string :description
      t.references :requester, foreign_key: { to_table: 'users' }
      t.integer :current_status
      t.datetime :start_at
      t.datetime :finish_date
      t.integer :kind
      t.float :time_forseen

      t.timestamps
    end
  end
end
