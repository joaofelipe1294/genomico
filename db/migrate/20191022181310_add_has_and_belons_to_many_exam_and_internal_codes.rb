class AddHasAndBelonsToManyExamAndInternalCodes < ActiveRecord::Migration[5.2]
  load 'app/models/concerns/exam_status_kinds.rb'
  def change
    create_table :exams_internal_codes do |t|
    	t.belongs_to :internal_code, index: true
      t.belongs_to :exam, index: true
    end
    Exam.where.not(exam_status_kind: ExamStatusKind.WAITING_START).where.not(attendance: nil).each do |exam|
      internal_code = InternalCode.find exam.internal_code_id
      exam.internal_codes << internal_code
    end
    remove_reference :exams, :internal_code
  end
end
