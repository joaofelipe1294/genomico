class CreateReleaseChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :release_checks do |t|
      t.references :user, foreign_key: true
      t.references :release, foreign_key: true
      t.boolean :has_confirmed

      t.timestamps
    end
  end
end
