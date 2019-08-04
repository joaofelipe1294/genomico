class AddAttachmentReportToAttendances < ActiveRecord::Migration[5.2]
  def self.up
    change_table :attendances do |t|
      t.attachment :report
    end
  end

  def self.down
    remove_attachment :attendances, :report
  end
end
