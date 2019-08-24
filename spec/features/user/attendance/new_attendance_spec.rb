require 'rails_helper'
require 'helpers/user'

def navigate_to_new_attendance
  do_login
  click_link id: 'patient-dropdown'
  click_link id: 'patients'
  click_link class: 'new-attendance', match: :first
end

def add_attendance_values
  select(@attendance.desease_stage.name, from: "attendance[desease_stage_id]").select_option if @attendance.desease_stage
  fill_in 'attendance[cid_code]', with: @attendance.cid_code if @attendance.cid_code
  fill_in 'attendance[lis_code]', with: @attendance.lis_code if @attendance.lis_code
  select(@attendance.health_ensurance.name, from: 'attendance[health_ensurance_id]').select_option if @attendance.health_ensurance
  fill_in 'attendance[doctor_name]', with: @attendance.doctor_name if @attendance.doctor_name
  fill_in 'attendance[doctor_crm]', with: @attendance.doctor_crm if @attendance.doctor_crm
  fill_in 'attendance[observations]', with: @attendance.observations if @attendance.observations
end

def add_exams
  click_button id: 'exams_nav'
  select(Field.last.name, from: "field_select").select_option
  select(OfferedExam.where(field: Field.last).last.name, from: "exams_select").select_option
  click_button id: 'btn_add_exam'
  select(Field.first.name, from: "field_select").select_option
  select(OfferedExam.where(field: Field.first).last.name, from: "exams_select").select_option
  click_button id: 'btn_add_exam'
end

def add_samples
  click_button id: 'samples_nav'
  click_button id: 'btn_add_sample'
end

RSpec.feature "User::Attendance::NewAttendances", type: :feature do

  before :each do
    Rails.application.load_seed
    Patient.create({
        name: 'Niv Mizzet',
        mother_name: 'Ur Dragon',
        medical_record: '7612387',
        birth_date: Date.today,
        hospital: Hospital.first
    })
  end

  context 'navigation' do

    it 'navigate without login', js: false do
      visit '/attendances/new/patient/1'
      expect(page).to have_current_path root_path
    end

  end

  context 'dinamic operations', js: true do

    it 'navigate between new attendance tabs' do
      navigate_to_new_attendance
      expect(find(id: 'attendance_tab')).to be_visible
      click_button id: 'exams_nav'
      expect(find(id: 'exams_tab')).to be_visible
      click_button id: 'samples_nav'
      expect(find(id: 'samples_tab')).to be_visible
      click_button id: 'attendance_nav'
      expect(find(id: 'attendance_tab')).to be_visible
    end

    it 'add exams' do
      navigate_to_new_attendance
      click_button id: 'exams_nav'
      expect(find_all('tr').size).to eq 1
      click_button id: 'btn_add_exam'
      expect(find_all('tr').size).to eq 2
    end

    it 'remove exams' do
      navigate_to_new_attendance
      click_button id: 'exams_nav'
      click_button id: 'btn_add_exam'
      expect(find_all('tr').size).to eq 2
      click_button class: 'btn-outline-danger', match: :first
      expect(find_all('tr').size).to eq 1
    end

    it 'add sample' do
      navigate_to_new_attendance
      click_button id: 'samples_nav'
      expect(find_all('tr').size).to eq 1
      click_button id: 'btn_add_sample'
      expect(find_all('tr').size).to eq 2
    end

    it 'remove sample' do
      navigate_to_new_attendance
      click_button id: 'samples_nav'
      click_button id: 'btn_add_sample'
      expect(find_all('tr').size).to eq 2
      click_button class: 'btn-outline-danger', match: :first
      expect(find_all('tr').size).to eq 1
    end

  end

  context 'correct', js: true do

    before :each do
      navigate_to_new_attendance
      @attendance = Attendance.new({
          patient: Patient.first,
          desease_stage: DeseaseStage.first,
          cid_code: '8761238716237',
          lis_code: '7615236751236',
          health_ensurance: HealthEnsurance.first,
          doctor_name: 'House',
          doctor_crm: '789612398',
          observations: 'Observações... Muuuuitas Bisservações'
      })
    end

    it 'complete' do
      add_attendance_values
      add_exams
      add_samples
      click_button id: 'btn-save-attendance'
      expect(find(id: 'success-warning').text).to eq "Atendimento cadastrado com sucesso."
    end

    it 'without cid' do
      @attendance.cid_code = nil
      add_attendance_values
      add_exams
      add_samples
      click_button id: 'btn-save-attendance'
      expect(find(id: 'success-warning').text).to eq "Atendimento cadastrado com sucesso."
    end

    it 'without health_ensurance' do
      @attendance.health_ensurance = nil
      add_attendance_values
      add_exams
      add_samples
      click_button id: 'btn-save-attendance'
      expect(find(id: 'success-warning').text).to eq "Atendimento cadastrado com sucesso."
    end

    it 'without doctor_name' do
      @attendance.doctor_name = nil
      add_attendance_values
      add_exams
      add_samples
      click_button id: 'btn-save-attendance'
      expect(find(id: 'success-warning').text).to eq "Atendimento cadastrado com sucesso."
    end

    it 'without doctor_crm' do
      @attendance.doctor_crm = nil
      add_attendance_values
      add_exams
      add_samples
      click_button id: 'btn-save-attendance'
      expect(find(id: 'success-warning').text).to eq "Atendimento cadastrado com sucesso."
    end

    it 'without observations' do
      @attendance.observations = nil
      add_attendance_values
      add_exams
      add_samples
      click_button id: 'btn-save-attendance'
      expect(find(id: 'success-warning').text).to eq "Atendimento cadastrado com sucesso."
    end

  end

  context 'correct' do

    before :each do
      Hospital.create({name: 'Hospital Pequeno Príncipe'})
      navigate_to_new_attendance
      @attendance = Attendance.new({
          patient: Patient.first,
          desease_stage: DeseaseStage.first,
          cid_code: '8761238716237',
          lis_code: '7615236751236',
          health_ensurance: HealthEnsurance.first,
          doctor_name: 'House',
          doctor_crm: '789612398',
          observations: 'Observações... Muuuuitas Bisservações'
      })
    end

    it 'without lis', js: true do
      @attendance.lis_code = nil
      add_attendance_values
      add_exams
      add_samples
      click_button id: 'btn-save-attendance'
      expect(find(class: 'error').text).to eq "Código LisNet não pode ficar em branco"
    end

    it 'without exams', js: true do
      add_attendance_values
      add_samples
      click_button id: 'btn-save-attendance'
      expect(find(class: 'error').text).to eq "Exames não pode ficar em branco"
    end

    it 'without exams', js: true do
      add_attendance_values
      add_exams
      click_button id: 'samples_nav'
      click_button id: 'btn-save-attendance'
      expect(find(class: 'error').text).to eq "Amostras não pode ficar em branco"
    end

    it "with duplicated lis_code", js: true do
      patient = create(:patient)
      Attendance.create({
          patient: Patient.first,
          desease_stage: DeseaseStage.first,
          cid_code: '8761238716237',
          lis_code: '7615236751236',
          health_ensurance: HealthEnsurance.first,
          doctor_name: 'House',
          doctor_crm: '789612398',
          attendance_status_kind: AttendanceStatusKind.last,
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
      add_attendance_values
      add_exams
      add_samples
      click_button id: 'btn-save-attendance'
      expect(find(class: 'error', match: :first).text).to eq "Código LisNet já está em uso"
    end

  end

end
