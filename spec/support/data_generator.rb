module DataGenerator

  def generate_users
  	User.create([
  		{login: Faker::Internet.username, password: '1234', kind: :user, name: Faker::Name.name},
  		{login: Faker::Internet.username, password: '1234', kind: :user, name: Faker::Name.name},
  		{login: Faker::Internet.username, password: '1234', kind: :user, name: Faker::Name.name},
  		{login: Faker::Internet.username, password: '1234', kind: :user, name: Faker::Name.name},
  		{login: Faker::Internet.username, password: '1234', kind: :user, name: Faker::Name.name}
  	])
  end

  def create_attendance
    samples = [
      Sample.new({
        sample_kind: SampleKind.PERIPHERAL_BLOOD,
        collection_date: 1.day.ago
      }),
      Sample.new({
        sample_kind: SampleKind.LIQUOR,
        collection_date: Date.today
      }),
    ]
    exams = [
      Exam.new({
        offered_exam: OfferedExam.where(is_active: true).where(field: Field.IMUNOFENO).sample
      }),
      Exam.new({
        offered_exam: OfferedExam.where(is_active: true).where(field: Field.IMUNOFENO).sample
      }),
      Exam.new({
        offered_exam: OfferedExam.where(is_active: true).where(field: Field.BIOMOL).sample
      })
    ]
    @attendance = Attendance.create({
      patient: create(:patient),
      desease_stage: DeseaseStage.DRM,
      lis_code: Faker::Number.number(digits: 10).to_s,
      start_date: Date.today,
      status: :progress,
      doctor_name: Faker::Name.name,
      doctor_crm: Faker::Number.number(digits: 6).to_s,
      observations: Faker::Lorem.sentence,
      health_ensurance: HealthEnsurance.all.sample,
      samples: samples,
      exams: exams
    })
  end

end
