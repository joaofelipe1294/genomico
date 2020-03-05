module AttendanceHelper

  def create_in_progress_imunofeno_attendance
    attendance = basic_imunofeno_attendance
    attendance.exams.first.status = :progress
    internal_code = create(:internal_code, sample: attendance.samples.first)
    internal_code = create(:internal_code, sample: attendance.samples.first, field: Field.IMUNOFENO)
    attendance.exams.first.internal_codes << internal_code
    attendance.save
    attendance
  end

  def create_raw_imunofeno_attendance
    attendance = basic_imunofeno_attendance
    attendance.save
    attendance
  end

  def create_in_progress_biomol_attendance
    attendance = basic_biomol_attendance
    attendance.exams.first.status = :progress
    attendance.exams.first.internal_codes << attendance.internal_codes.sample
    attendance.save
    attendance
  end

  def create_raw_biomol_attendance
    attendance = basic_biomol_attendance
    attendance.save
    attendance
  end

  def create_complete_biomol_attendance
    attendance = basic_biomol_attendance
    attendance.exams.first.status = :complete
    attendance.exams.first.internal_codes << attendance.internal_codes.sample
    attendance.status = :complete
    attendance.finish_date = Date.current
    attendance.save
    attendance
  end

  def create_in_progress_fish_attendance
    attendance = basic_fish_attendance
    attendance.exams.first.status = :progress
    attendance.exams.first.internal_codes << attendance.internal_codes.sample
    attendance.save
    attendance
  end

  private

    def basic_imunofeno_attendance
      exam = build(:exam, offered_exam: create(:offered_exam, field: Field.IMUNOFENO), start_date: nil, finish_date: nil, status: :waiting_start)
      sample = build(:sample, sample_kind: SampleKind.LIQUOR)
      attendance = create(:attendance, exams: [exam], samples: [sample], status: :progress)
      attendance
    end

    def basic_biomol_attendance
      exam = build(:exam, offered_exam: create(:offered_exam, field: Field.BIOMOL), start_date: nil, finish_date: nil, status: :waiting_start)
      sample = build(:sample, sample_kind: SampleKind.PERIPHERAL_BLOOD)
      attendance = create(:attendance, exams: [exam], samples: [sample], status: :progress)
      create(:subsample, sample: attendance.samples.first, subsample_kind: SubsampleKind.DNA)
      create(:subsample, sample: attendance.samples.first, subsample_kind: SubsampleKind.RNA)
      create(:subsample, sample: attendance.samples.first, subsample_kind: SubsampleKind.VIRAL_DNA)
      attendance
    end

    def basic_fish_attendance
      exam = build(:exam, offered_exam: create(:offered_exam, field: Field.FISH), start_date: nil, finish_date: nil, status: :waiting_start)
      sample = build(:sample, sample_kind: SampleKind.PERIPHERAL_BLOOD)
      attendance = create(:attendance, exams: [exam], samples: [sample], status: :progress)
      create(:subsample, sample: attendance.samples.first, subsample_kind: SubsampleKind.PELLET)
      attendance
    end

end
