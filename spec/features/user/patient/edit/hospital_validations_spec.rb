require 'rails_helper'

RSpec.feature "User::Patient::Edit::HospitalValidations", type: :feature do
  include UserLogin
  include ValidationChecks
  include PatientHelpers

  context "simple validations" do

    before :each do
      Rails.application.load_seed
      navigate_to_edit_patient
    end

    it 'hospital' do
      new_value = Hospital.find_by name: 'Orzhov'
      select(new_value.name, from: :patient_hospital_id).select_option
      success_check home_user_index_path, :edit_patient_success
      edited_patient = Patient.find_by hospital: new_value
      expect(edited_patient.hospital).to eq new_value
    end

    it 'with all values' do
      new_value = Patient.new({
        name: 'Trostani, a voz de Vitu-gazzi',
        mother_name: 'Vitu-gazzi a árvore primordial',
        birth_date: Date.today,
        medical_record: '98761237',
        hospital: Hospital.find_by(name: 'Selesnya')
      })
      fill_in :patient_name, with: new_value.name
      fill_in :patient_mother_name, with: new_value.mother_name
      fill_in :patient_birth_date, with: new_value.birth_date
      fill_in :patient_medical_record, with: new_value.medical_record
      select(new_value.hospital.name, from: :patient_hospital_id).select_option
      success_check home_user_index_path, :edit_patient_success
      edited_patient = Patient.find_by name: new_value.name
      expect(edited_patient.name).to eq new_value.name
      expect(edited_patient.mother_name).to eq new_value.mother_name
      expect(edited_patient.birth_date).to eq new_value.birth_date
      expect(edited_patient.medical_record).to eq new_value.medical_record
      expect(edited_patient.hospital).to eq new_value.hospital
    end
  end

  context 'duplicated values HPP' do

    before :each do
      Rails.application.load_seed
      @patient = create(:patient, hospital: Hospital.HPP)
      @duplicated = create(:patient, hospital: Hospital.HPP)
      imunofeno_user_do_login
      fill_in id: 'patient-name-search', with: @duplicated.name
      click_button id: 'btn-search-patient'
      click_link class: 'patient-info', match: :first
      click_link class: 'edit-patient', match: :first
    end

    it "name, mother_name, birth_date and HPP" do
      fill_in :patient_name, with: @patient.name
      fill_in :patient_mother_name, with: @patient.mother_name
      fill_in :patient_birth_date, with: @patient.birth_date
      select(@patient.hospital.name, from: :patient_hospital_id).select_option
      click_button class: 'btn-outline-primary'
      expect(find(class: 'error').text).to eq "Nome já está em uso"
    end

    it "medical record HPP" do
      fill_in :patient_medical_record, with: @patient.medical_record
      click_button class: 'btn-outline-primary'
      expect(find(class: 'error').text).to eq "Prontuário médico já está em uso"
    end

  end

end
