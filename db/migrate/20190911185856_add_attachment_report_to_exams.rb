class AddAttachmentReportToExams < ActiveRecord::Migration[5.2]
  def self.up
    change_table :exams do |t|
      t.attachment :report
    end
    Exam.includes(:attendance).all.each do |exam|
      unless exam.attendance.nil?
        exam.report = exam.attendance.report if exam.attendance.report?
        exam.save
      end
    end
  end

  def self.down
    remove_attachment :exams, :report
  end
end
