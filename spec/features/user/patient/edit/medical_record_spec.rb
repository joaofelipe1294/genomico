require 'rails_helper'

RSpec.feature "User::Patient::Edit::MedicalRecords", type: :feature do
  include UserLogin
  include PatientHelpers

  context "simple validations" do

    before :each do
      Rails.application.load_seed
      navigate_to_edit_patient
    end

    it 'name' do
      fill_in :patient_name, with: "   "
      click_button class: 'btn-outline-primary'
      expect(find(class: 'error', match: :first).text).to eq "Nome não pode ficar em branco"
    end

    it 'mother_name and hospital NOT HPP' do
      Hospital.create({name: 'AAA'})
      fill_in :patient_mother_name, with: "   "
      click_button class: 'btn-outline-primary'
      expect(find(id: 'success-warning').text).to eq "Paciente editado com sucesso."
    end

    it 'mother_name and hospital HPP' do
      hpp = Hospital.find_by({name: "Hospital Pequeno Príncipe"})
      select(hpp.name, from: :patient_hospital_id).select_option
      fill_in :patient_mother_name, with: "   "
      click_button class: 'btn-outline-primary'
      expect(find(id: 'success-warning').text).to eq "Paciente editado com sucesso."
    end

  end

  it 'medical_record patient with distinct HPP hospital' do
    Rails.application.load_seed
    imunofeno_user_do_login
    hospital = Hospital.create(name: 'AAA')
    patient = create(:patient, hospital: hospital)
    find_patient_by_name_and_go_to_edit patient
    fill_in :patient_medical_record, with: "   "
    click_button class: 'btn-outline-primary'
    expect(find(id: 'success-warning').text).to eq "Paciente editado com sucesso."
  end

end
