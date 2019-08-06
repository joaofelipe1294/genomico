def create_attendance
  Rails.application.load_seed
  @patient = Patient.create({
    name: 'Niv-Mizzet',
    birth_date: 3.year.ago,
    mother_name: 'Ur dragon',
    medical_record: '287612837',
    hospital: Hospital.last
  })
  @attendance = Attendance.create({
    desease_stage: DeseaseStage.first,
    cid_code: "7612536",
    lis_code: "367",
    start_date: 2.day.ago,
    patient: @patient,
    attendance_status_kind: AttendanceStatusKind.first,
    doctor_name: 'Hal-zarek',
    doctor_crm: '87152385',
    observations: 'Niv-Mizzet is the One',
    health_ensurance: HealthEnsurance.all.sample,
    exams: [
      Exam.new({
        offered_exam: OfferedExam.where(field: Field.last).last
      }),
    ],
    samples: [
      Sample.new({
        sample_kind: SampleKind.last,
        collection_date: Date.today,
        entry_date: Date.today,
        storage_location: 'Geladeira 3',
        bottles_number: 3
      })
    ]
  })
end

def navigate_to_workflow
  fill_in id: 'lis_code_search', with: @attendance.lis_code
  click_button class: 'btn-outline-success'
end
