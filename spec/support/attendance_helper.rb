module AttendanceHelper

  def create_imunofeno_attendance
    exam = build(:exam, offered_exam: OfferedExam.where(field: Field.IMUNOFENO).where(is_active: true).sample)
    sample = build(:sample, sample_kind: SampleKind.LIQUOR)
    attendance = create(:attendance, exams: [exam], samples: [sample])
    internal_code = create(:internal_code, sample: sample, field: Field.IMUNOFENO)
    attendance.exams.first.exam_status_kind = ExamStatusKind.IN_PROGRESS
    attendance.exams.first.internal_codes << internal_code
    attendance.save
    attendance
  end

  def create_biomol_attendance
    exam = build(:exam, offered_exam: OfferedExam.where(field: Field.BIOMOL).where(is_active: true).sample)
    sample = build(:sample, sample_kind: SampleKind.PERIPHERAL_BLOOD)
    attendance = create(:attendance, exams: [exam], samples: [sample])
    create(:subsample, sample: attendance.samples.first, subsample_kind: SubsampleKind.DNA)
    create(:subsample, sample: attendance.samples.first, subsample_kind: SubsampleKind.RNA)
    create(:subsample, sample: attendance.samples.first, subsample_kind: SubsampleKind.VIRAL_DNA)
    attendance.exams.first.exam_status_kind = ExamStatusKind.IN_PROGRESS
    attendance.exams.first.internal_codes << attendance.internal_codes.sample
    attendance.save
    attendance
  end

end
