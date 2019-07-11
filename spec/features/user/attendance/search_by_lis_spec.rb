require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Attendance::SearchByLis", type: :feature do

  it 'search by lis', js: false do
    Rails.application.load_seed
    patient = create(:patient)
    attendance = Attendance.create({
        patient: Patient.first,
        desease_stage: DeseaseStage.first,
        cid_code: '8761238716237',
        lis_code: '7615236751236',
        health_ensurance: HealthEnsurance.first,
        doctor_name: 'House',
        doctor_crm: '789612398',
        attendance_status_kind: AttendanceStatusKind.first,
        observations: 'Observações... Muuuuitas Bisservações',
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
    do_login
    fill_in id: 'lis_code_search', with: '7615236751236'
    click_button class: 'btn-outline-success', match: :first
    expect(page).to have_current_path '/attendances/1/workflow'
  end

  it 'with invalid lis_code' do
    user_do_login
    fill_in id: 'lis_code_search', with: '7615236751236'
    click_button class: 'btn-outline-success', match: :first
    expect(page).to have_current_path home_user_index_path
    expect(find(id: 'danger-warning').text).to eq "O código LisNet informado não esta vinculado a nenhum atendimento."
  end

end
