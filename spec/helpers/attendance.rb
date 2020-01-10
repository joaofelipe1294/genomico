# def create_attendance
#   Rails.application.load_seed
#   @patient = Patient.create({
#     name: 'Niv-Mizzet',
#     birth_date: 3.year.ago,
#     mother_name: 'Ur dragon',
#     medical_record: '287612837',
#     hospital: Hospital.last
#   })
#   @attendance = Attendance.create({
#     desease_stage: DeseaseStage.first,
#     cid_code: "7612536",
#     lis_code: "367",
#     start_date: 2.day.ago,
#     patient: @patient,
#     attendance_status_kind: AttendanceStatusKind.first,
#     doctor_name: 'Hal-zarek',
#     doctor_crm: '87152385',
#     observations: 'Niv-Mizzet is the One',
#     health_ensurance: HealthEnsurance.all.sample,
#     exams: [
#       Exam.new({
#         offered_exam: OfferedExam.where(field: Field.find_by(name: 'Imunofenotipagem')).last
#       }),
#     ],
#     samples: [
#       Sample.new({
#         sample_kind: SampleKind.last,
#         collection_date: Date.today,
#         entry_date: Date.today,
#         storage_location: 'Geladeira 3',
#       })
#     ]
#   })
# end
#
# def navigate_to_workflow
#   fill_in id: 'patient-name-search', with: @attendance.patient.name
#   click_button class: 'btn-outline-success'
#   click_link class: 'btn-outline-info'
#   click_link class: 'btn-outline-primary'
# end
#
# def set_subsample_values
#   select(SubsampleKind.all.sample.name, from: 'subsample[subsample_kind_id]').select_option
#   fill_in 'subsample[storage_location]', with: 'F -80'
#   fill_in 'subsample[nanodrop_report_attributes][rate_260_280]', with: Faker::Number.decimal(l_digits: 2) #.to_s.gsub('.', ',')
#   fill_in 'subsample[nanodrop_report_attributes][rate_260_230]', with: Faker::Number.decimal(l_digits: 2) #.to_s.gsub('.', ',')
#   fill_in 'subsample[nanodrop_report_attributes][concentration]', with: Faker::Number.decimal(l_digits: 2) #.to_s.gsub('.', ',')
#   fill_in 'subsample[qubit_report_attributes][concentration]', with: Faker::Number.decimal(l_digits: 2) #.to_s.gsub('.', ',')
# end
#
# def extract_subsample
#   click_button id: 'sample_nav'
#   click_link class: 'new-subsample', match: :first
#   set_subsample_values
#   click_button id: 'btn-save-subsample'
#   click_button id: 'subsample_nav'
# end
#
#
# def create_attendance
#   samples = [
#     Sample.new({
#       sample_kind: SampleKind.PERIPHERAL_BLOOD,
#       collection_date: 1.day.ago
#     }),
#     Sample.new({
#       sample_kind: SampleKind.LIQUOR,
#       collection_date: Date.today
#     }),
#   ]
#   exams = [
#     Exam.new({
#       offered_exam: OfferedExam.where(is_active: true).where(field: Field.IMUNOFENO).sample
#     }),
#     Exam.new({
#       offered_exam: OfferedExam.where(is_active: true).where(field: Field.IMUNOFENO).sample
#     }),
#     Exam.new({
#       offered_exam: OfferedExam.where(is_active: true).where(field: Field.BIOMOL).sample
#     })
#   ]
#   @attendance = Attendance.create({
#     patient: create(:patient),
#     desease_stage: DeseaseStage.DRM,
#     lis_code: Faker::Number.number(digits: 10).to_s,
#     start_date: Date.today,
#     attendance_status_kind: AttendanceStatusKind.IN_PROGRESS,
#     doctor_name: Faker::Name.name,
#     doctor_crm: Faker::Number.number(digits: 6).to_s,
#     observations: Faker::Lorem.sentence,
#     health_ensurance: HealthEnsurance.all.sample,
#     samples: samples,
#     exams: exams
#   })
# end
