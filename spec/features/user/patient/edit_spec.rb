require 'rails_helper'
require 'helpers/user'

def navigate_to_edit_patient patient
  user_do_login
  click_link id: 'patient-dropdown'
  click_link id: 'patients'
  fill_in id: 'patient-name-search', with: patient.name
  click_button id: 'btn-search-by-name'
  click_link class: 'patient-info', match: :first
  click_link class: 'edit-patient'
end

def correct_expetations
  click_button class: 'btn-outline-primary'
  expect(page).to have_current_path home_user_index_path
  expect(find(id: 'success-warning').text).to eq "Paciente editado com sucesso."
end

RSpec.feature "User::Patient::Edits", type: :feature do

  context 'correct single attributes' do

    before :each do
      create(:patient)
      create(:patient)
      create(:patient)
      patient = create(:patient, name: 'Momir Vig')
      navigate_to_edit_patient patient
    end

    it 'name', js: false do
      fill_in :patient_name, with: 'Este é um novo nome'
      correct_expetations
      edited_patient = Patient.find_by(name: 'Este é um novo nome')
      expect(edited_patient.name).to eq 'Este é um novo nome'
    end

    it 'birth_date' do
      new_value = Date.today
      fill_in :patient_birth_date, with: new_value
      correct_expetations
      edited_patient = Patient.find_by birth_date: new_value
      expect(edited_patient.birth_date).to eq new_value
    end

    it 'mother_name' do
      new_value = 'Razia o anjo dos Boros'
      fill_in :patient_mother_name, with: new_value
      correct_expetations
      edited_patient = Patient.find_by mother_name: new_value
      expect(edited_patient.mother_name).to eq new_value
    end

    it 'medical_record' do
      new_value = '87162372367'
      fill_in :patient_medical_record, with: new_value
      correct_expetations
      edited_patient = Patient.find_by medical_record: new_value
      expect(edited_patient.medical_record).to eq new_value
    end

    it "observations" do
      new_value = 'Alguma observação bem importante ...'
      fill_in :patient_observations, with: new_value
      correct_expetations
      edited_patient = Patient.find_by observations: new_value
      expect(edited_patient.observations).to eq new_value
    end

  end

  context 'correct with hospital created' do

    before :each do
      Hospital.create([{name: 'Orzhov'}, {name: 'Rakdos'}, {name: 'Selesnya'}])
      create(:patient)
      create(:patient)
      create(:patient)
      patient = create(:patient, name: 'Momir Vig')
      navigate_to_edit_patient patient
    end

    it 'hospital', js: false do
      new_value = Hospital.find_by name: 'Orzhov'
      select(new_value.name, from: :patient_hospital_id).select_option
      correct_expetations
      edited_patient = Patient.find_by hospital: new_value
      expect(edited_patient.hospital).to eq new_value
    end

    it 'with all values', js: false do
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
      correct_expetations
      edited_patient = Patient.find_by name: new_value.name
      expect(edited_patient.name).to eq new_value.name
      expect(edited_patient.mother_name).to eq new_value.mother_name
      expect(edited_patient.birth_date).to eq new_value.birth_date
      expect(edited_patient.medical_record).to eq new_value.medical_record
      expect(edited_patient.hospital).to eq new_value.hospital
    end

  end

  context 'without values' do

    before :each do
      Hospital.create([{name: 'Orzhov'}, {name: 'Rakdos'}, {name: 'Selesnya'}, {name: 'Azorius'}, {name: 'Hospital Pequeno Príncipe'}])
      create(:patient)
      create(:patient)
      create(:patient)
      patient = create(:patient, name: 'Momir Vig')
      navigate_to_edit_patient patient
    end

    it 'name' do
      fill_in :patient_name, with: "   "
      click_button class: 'btn-outline-primary'
      expect(find(class: 'error', match: :first).text).to eq "Nome não pode ficar em branco"
    end

    it 'mother_name and hospital NOT HPP', js: false do
      Hospital.create({name: 'AAA'})
      fill_in :patient_mother_name, with: "   "
      click_button class: 'btn-outline-primary'
      expect(find(id: 'success-warning').text).to eq "Paciente editado com sucesso."
    end

    it 'mother_name and hospital HPP', js: false do
      hpp = Hospital.find_by({name: "Hospital Pequeno Príncipe"})
      select(hpp.name, from: :patient_hospital_id).select_option
      fill_in :patient_mother_name, with: "   "
      click_button class: 'btn-outline-primary'
      expect(find(id: 'success-warning').text).to eq "Paciente editado com sucesso."
    end

    it 'medical_record', js: false do
      Hospital.create(name: 'AAA')
      fill_in :patient_medical_record, with: "   "
      click_button class: 'btn-outline-primary'
      expect(find(id: 'success-warning').text).to eq "Paciente editado com sucesso."
    end

  end

  context 'duplicated values HPP' do

    before :each do
      hpp = Hospital.create({name: 'Hospital Pequeno Príncipe'})
      @patient = Patient.create({
        name: 'Zero',
        mother_name: 'Zera',
        birth_date: Date.today,
        medical_record: '123456',
        hospital: hpp
      })
      @duplicated = Patient.create({
        name: 'Um',
        mother_name: 'Uma',
        birth_date: 2.days.ago,
        medical_record: '654321',
        hospital: hpp
      })
      user_do_login
      fill_in id: 'patient-name-search', with: @duplicated.name
      click_button id: 'btn-search-patient'
      click_link class: 'patient-info', match: :first
      click_link class: 'edit-patient', match: :first
    end

    it "name, mother_name, birth_date and HPP", js: false do
      fill_in :patient_name, with: @patient.name
      fill_in :patient_mother_name, with: @patient.mother_name
      fill_in :patient_birth_date, with: @patient.birth_date
      select(@patient.hospital.name, from: :patient_hospital_id).select_option
      click_button class: 'btn-outline-primary'
      expect(find(class: 'error').text).to eq "Nome já está em uso"
    end

    it "medical record HPP", js: false do
      fill_in :patient_medical_record, with: @patient.medical_record
      click_button class: 'btn-outline-primary'
      expect(find(class: 'error').text).to eq "Prontuário médico já está em uso"
    end

  end

  context "Duplicated medical_record no HPP" do

    it "medical_record" do
      hpp = Hospital.create({name: 'Hospital DIFERENTE DO Pequeno Príncipe'})
      @patient = Patient.create({
        name: 'Zero',
        mother_name: 'Zera',
        birth_date: Date.today,
        medical_record: '123456',
        hospital: hpp
      })
      @duplicated = Patient.create({
        name: 'Um',
        mother_name: 'Uma',
        birth_date: 2.days.ago,
        medical_record: '654321',
        hospital: hpp
      })
      user_do_login
      fill_in id: 'patient-name-search', with: @duplicated.name
      click_button id: 'btn-search-patient'
      click_link class: 'patient-info', match: :first
      click_link class: 'edit-patient'
      fill_in :patient_medical_record, with: @patient.medical_record
      click_button class: 'btn-outline-primary'
      expect(find(class: 'error').text).to eq "Prontuário médico já está em uso"
    end

  end

end
