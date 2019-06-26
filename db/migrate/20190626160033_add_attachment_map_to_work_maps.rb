class AddAttachmentMapToWorkMaps < ActiveRecord::Migration
  def self.up
    change_table :work_maps do |t|
      t.attachment :map
    end
  end

  def self.down
    remove_attachment :work_maps, :map
  end
end
