require 'rails_helper'

RSpec.feature "User::Patient::Edit::SingleAttributeChanges", type: :feature do
  include UserLogin
  include ValidationChecks
  include PatientHelpers

  before :each do
    Rails.application.load_seed
    navigate_to_edit_patient
  end

  it 'name' do
    fill_in :patient_name, with: 'Este é um novo nome'
    success_check home_user_index_path, :edit_patient_success
    edited_patient = Patient.find_by(name: 'Este é um novo nome')
    expect(edited_patient.name).to eq 'Este é um novo nome'
  end

  it 'birth_date' do
    new_value = Date.today
    fill_in :patient_birth_date, with: new_value
    success_check home_user_index_path, :edit_patient_success
    edited_patient = Patient.find_by birth_date: new_value
    expect(edited_patient.birth_date).to eq new_value
  end

  it 'mother_name' do
    new_value = 'Razia o anjo dos Boros'
    fill_in :patient_mother_name, with: new_value
    success_check home_user_index_path, :edit_patient_success
    edited_patient = Patient.find_by mother_name: new_value
    expect(edited_patient.mother_name).to eq new_value
  end

  it 'medical_record' do
    new_value = '87162372367'
    fill_in :patient_medical_record, with: new_value
    success_check home_user_index_path, :edit_patient_success
    edited_patient = Patient.find_by medical_record: new_value
    expect(edited_patient.medical_record).to eq new_value
  end

  it "observations" do
    new_value = 'Alguma observação bem importante ...'
    fill_in :patient_observations, with: new_value
    success_check home_user_index_path, :edit_patient_success
    edited_patient = Patient.find_by observations: new_value
    expect(edited_patient.observations).to eq new_value
  end

end
