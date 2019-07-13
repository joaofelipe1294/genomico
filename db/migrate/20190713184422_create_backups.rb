class CreateBackups < ActiveRecord::Migration
  def change
    create_table :backups do |t|
      t.datetime :generated_at
      t.boolean :status

      t.timestamps null: false
    end
  end
end
