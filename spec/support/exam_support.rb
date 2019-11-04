module ExamSupport

  def biomol_exam
    Exam.new({
      offered_exam: OfferedExam.where(field: Field.BIOMOL).sample
      })
  end

end
