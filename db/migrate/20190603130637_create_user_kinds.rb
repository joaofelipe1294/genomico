class CreateUserKinds < ActiveRecord::Migration[5.2]
  def change
    create_table :user_kinds do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
