namespace :dev_db do
  desc "Add some registers to development database"
  task populate: :environment do
    Rails.application.load_seed

    puts "\n\n"
    puts "=============================="
    puts "Adicionado Hospitais ..."
    if Hospital.all.size < 20
      (1..25).step() do
        Hospital.create({
          name: Faker::Company.name
        })
      end
    end
    puts "=============================="
    puts "Adicionando pacientes"
    if Patient.all.size < 50
      (1..50).step(1) do
        patient = Patient.create({
          name: Faker::Name.name,
          birth_date: Faker::Date.between(from: 18.days.ago, to: Date.today),
          mother_name: Faker::Name.name,
          medical_record: Faker::Number.number(digits: 12),
          hospital: Hospital.all.sample
        })
        p patient
      end
    end
    puts "=============================="
    puts "Adicionando atendimentos"
    if Attendance.all.size < 150
      (1..150).step(1) do
        attendance = Attendance.new({
          patient: Patient.all.sample,
          attendance_status_kind: AttendanceStatusKind.find_by({name: 'Em andamento'}),
          desease_stage: DeseaseStage.all.sample,
          cid_code: Faker::Number.number(digits: 7),
          lis_code: Faker::Number.number(digits: 13),
          health_ensurance: HealthEnsurance.all.sample,
          doctor_name: Faker::Name.name,
          doctor_crm: Faker::Number.number(digits: 4),
          start_date: Faker::Date.between(from: 15.days.ago, to: Date.today)
        })
        (1..rand(2..12)).each do |value|
          exam = Exam.new({
            offered_exam: OfferedExam.where({field: Field.all.sample}).sample,
          })
          attendance.exams.push(exam)
        end
        (1..rand(2..4)).step(1) do
          sample = Sample.new({
            sample_kind: SampleKind.all.sample,
            bottles_number: 1,
            collection_date: Faker::Date.between(from: 8.months.ago, to: Date.today),
          })
          attendance.samples.push(sample)
        end
        attendance.save
        puts attendance.id
        puts "\n============================================================\n"
      end

    end
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
