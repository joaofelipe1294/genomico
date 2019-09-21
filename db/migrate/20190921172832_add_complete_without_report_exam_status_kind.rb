class AddCompleteWithoutReportExamStatusKind < ActiveRecord::Migration[5.2]
  def change
    ExamStatusKind.create({name: 'Concluído (sem laudo)'})
  end
end
