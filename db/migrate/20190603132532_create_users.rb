class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login
      t.string :password_digest
      t.string :name
      t.boolean :is_active
      t.references :user_kind, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
