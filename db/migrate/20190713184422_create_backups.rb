class CreateBackups < ActiveRecord::Migration[5.2]
  def change
    create_table :backups do |t|
      t.datetime :generated_at
      t.boolean :status
      t.string :dump_path

      t.timestamps null: false
    end
  end
end
