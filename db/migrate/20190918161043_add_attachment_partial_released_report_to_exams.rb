class AddAttachmentPartialReleasedReportToExams < ActiveRecord::Migration[5.2]
  def self.up
    ExamStatusKind.create(name: 'Liberado parcial')
    change_table :exams do |t|
      t.attachment :partial_released_report
    end
  end

  def self.down
    remove_attachment :exams, :partial_released_report
    ExamStatusKind.find_by(name: 'Liberado parcial').delete
  end
end
