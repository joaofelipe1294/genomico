require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Patient::Lists", type: :feature do

  context 'with registers' do

    before :each do
      create(:patient)
      create(:patient)
      create(:patient)
      user_do_login
      click_link(id: 'patient-dropdown')
      click_link(id: 'patients')
      expect(page).to have_current_path patients_path
    end

    it 'list 3 patients' do
      patients = find_all(class: 'patient')
      expect(patients.size).to eq Patient.all.size
    end

    it 'search by name', js: false do
      patient = create(:patient, name: 'Nome do paciente')
      fill_in id: 'patient-name', with: patient.name
      click_button id: 'btn-search-by-name'
      patients_found = find_all class: 'patient'
      expect(patients_found.size).to eq 1
    end

    it 'search by medical_record' do
      patient = create(:patient, medical_record: Faker::Number.number(6).to_s)
      fill_in 'medical-record', with: patient.medical_record
      click_button 'btn-search-by-medical-record'
      expect(find_all(class: 'patient').size).to eq 1
    end

  end

  context 'without records' do

    it 'search by invalid medical record' do
      user_do_login
      click_link(id: 'patient-dropdown')
      click_link(id: 'patients')
      fill_in 'medical-record', with: '8712563876'
      click_button 'btn-search-by-medical-record'
      expect(find_all(class: 'patient').size).to eq 0
    end

  end

end
