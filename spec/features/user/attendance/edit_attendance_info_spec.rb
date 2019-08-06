require 'rails_helper'
require 'helpers/user'

def populate_database
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

def send_form_and_validate
  click_button class: 'btn-outline-primary'
  expect(find(id: 'success-warning').text).to eq "Atendimento atualizado com sucesso."
end


RSpec.feature "User::Attendance::EditAttendanceInfos", type: :feature do

  context 'Correct change attendance info' do

    before :each do
      user_do_login
      populate_database
      navigate_to_workflow
    end

    it "Change desease stage", js: false do
      select(DeseaseStage.last.name, from: "attendance[desease_stage_id]").select_option
      send_form_and_validate
    end

    it 'Change Cid Dode' do
      fill_in 'attendance[cid_code]', with: "9871298371"
      send_form_and_validate
    end

    it "Remove Cid Code" do
      fill_in 'attendance[cid_code]', with: ""
      send_form_and_validate
    end

    it "Change Lis Code" do
      fill_in 'attendance[lis_code]', with: "876123876123"
      send_form_and_validate
    end

    it "Duplicated Lis Code" do
      duplicated_attendance = build(:attendance, lis_code: '123321')
      duplicated_attendance.save
      fill_in 'attendance[lis_code]', with: '123321'
      click_button class: 'btn-outline-primary'
      expect(find(class: 'error').text).to eq "Código LisNet já está em uso"
    end

    it "Without Lis Code" do
      fill_in 'attendance[lis_code]', with: ''
      click_button class: 'btn-outline-primary'
      expect(find(class: 'error').text).to eq "Código LisNet não pode ficar em branco"
    end

    it "Change Health Ensurance" do
      select(HealthEnsurance.all.sample.name, from: "attendance[health_ensurance_id]").select_option
      send_form_and_validate
    end

    it "Change doctor name" do
      fill_in 'attendance[doctor_name]', with: 'Azor'
      send_form_and_validate
    end

    it "Remove doctor name" do
      fill_in 'attendance[doctor_name]', with: ''
      send_form_and_validate
    end

    it "Change doctor CRM" do
      fill_in 'attendance[doctor_crm]', with: '761237896'
      send_form_and_validate
    end

    it "Remove doctor CRM" do
      fill_in 'attendance[doctor_crm]', with: ''
      send_form_and_validate
    end

    it "Change observations" do
      fill_in 'attendance[observations]', with: 'This observation was changed'
      send_form_and_validate
    end

    it "Remove observation" do
      fill_in 'attendance[observations]', with: ''
      send_form_and_validate
    end

    it "Remove All non required fields" do
      fill_in 'attendance[cid_code]', with: ''
      fill_in 'attendance[doctor_name]', with: ''
      fill_in 'attendance[doctor_crm]', with: ''
      fill_in 'attendance[observations]', with: ''
    end

  end
  
end
