# require 'rails_helper'
# require 'helpers/user'
#
# RSpec.feature "User::Attendance::SearchByLis", type: :feature do
#
#   it 'search by patient name', js: false do
#     Rails.application.load_seed
#     patient = create(:patient)
#     attendance = Attendance.create({
#         patient: Patient.first,
#         desease_stage: DeseaseStage.first,
#         cid_code: '8761238716237',
#         lis_code: '7615236751236',
#         health_ensurance: HealthEnsurance.first,
#         doctor_name: 'House',
#         doctor_crm: '789612398',
#         attendance_status_kind: AttendanceStatusKind.first,
#         observations: 'Observações... Muuuuitas Bisservações',
#         exams: [
#           Exam.new({
#             offered_exam: OfferedExam.where(field: Field.last).last
#           }),
#         ],
#         samples: [
#           Sample.new({
#             sample_kind: SampleKind.last,
#             collection_date: Date.today,
#             entry_date: Date.today,
#             storage_location: 'Geladeira 3',
#             bottles_number: 3
#           })
#         ]
#     })
#     do_login
#     fill_in 'name_search', with: attendance.patient.name
#     click_button class: 'btn-outline-success', match: :first
#     click_link class: 'btn-outline-info'
#     click_link class: 'btn-outline-primary'
#     expect(page).to have_current_path '/attendances/1/workflow'
#   end
#
#   it 'with invalid lis_code' do
#     user_do_login
#     fill_in 'name_search', with: 'Algum nome que não existe'
#     click_button class: 'btn-outline-success', match: :first
#     expect(page).to have_selector('#patients-list', visible: true)
#   end
#
# end
