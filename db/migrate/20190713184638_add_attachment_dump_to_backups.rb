class AddAttachmentDumpToBackups < ActiveRecord::Migration
  def self.up
    change_table :backups do |t|
      t.attachment :dump
    end
  end

  def self.down
    remove_attachment :backups, :dump
  end
end
