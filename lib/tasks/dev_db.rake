namespace :dev_db do
  desc "Add some registers to development database"
  task populate: :environment do
    Rails.application.load_seed

    puts "\n\n"
    puts "=============================="
    puts "Adicionado Hospitais ..."
    5.times do
      Hospital.create(name: Faker::Company.name)
    end
    puts "=============================="
    puts "Adicionando pacientes"
    15.times do
      Patient.create({
        name: Faker::Name.name,
        birth_date: Faker::Date.between(from: 18.days.ago, to: Date.today),
        mother_name: Faker::Name.name,
        medical_record: Faker::Number.number(digits: 12),
        hospital: Hospital.all.sample
      })
    end
    puts "=============================="
    puts "Adicionando planos de saude"
    3.times do
      HealthEnsurance.create(name: Faker::Company.name)
    end
    puts "=============================="
    #puts "Adicionando atendimentos"
    #15.times do
    #  attendance = Attendance.create({
    #    patient: Patient.all.sample,
    #    status: :progress,
    #    desease_stage: :drm,
    #    cid_code: Faker::Number.number(digits: 7),
    #    lis_code: Faker::Number.number(digits: 13),
    #    health_ensurance: HealthEnsurance.all.sample,
    #    doctor_name: Faker::Name.name,
    #    doctor_crm: Faker::Number.number(digits: 4),
    #    start_date: Faker::Date.between(from: 15.days.ago, to: Date.today)
    #  })
    #  exam = Exam.new({
    #    offered_exam: OfferedExam.where({field: Field.all.sample}).sample,
    #  })
    #  attendance.exams << exam
    #
    #  sample = Sample.new({
    #    sample_kind: SampleKind.all.sample,
    #    collection_date: Faker::Date.between(from: 8.months.ago, to: Date.today),
    #  })
    #  attendance.samples << sample
    #  attendance.save
    #  puts "\n============================================================\n"
    #end
    #
    # concluded = ExamStatusKind.find_by({name: 'Concluído'})
    # Attendance.all.each do |attendance|
    #   attendance.exams.each do |exam|
    #     exam.sample = attendance.samples.first
    #     exam.exam_status_kind = concluded
    #   end
    #   attendance.attendance_status_kind = AttendanceStatusKind.find_by({name: 'Concluído'})
    #   attendance.finish_date = DateTime.now
    #   attendance.save
    #   puts attendance.id
    # end
  end

end
