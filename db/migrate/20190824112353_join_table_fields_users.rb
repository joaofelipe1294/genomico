class JoinTableFieldsUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :fields, :users do |t|
      t.index [:field_id, :user_id]
    end
  end
end
