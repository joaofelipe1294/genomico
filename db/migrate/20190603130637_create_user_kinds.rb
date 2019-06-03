class CreateUserKinds < ActiveRecord::Migration
  def change
    create_table :user_kinds do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
