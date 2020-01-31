class RemoveUserKinds < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :kind, :integer
    User.all.each { |user| user.update kind: user.user_kind.id }
    remove_column :users, :user_kind_id
    drop_table :user_kinds
  end
end
