require 'rails_helper'

RSpec.feature "User::Patient::New::Validations", type: :feature do
  include PatientHelpers
  include UserLogin

	before :each do
    	Rails.application.load_seed
    	imunofeno_user_do_login
    	click_link(id: 'patient-dropdown')
    	click_link(id: 'new-patient')
    	@patient = build(:patient, hospital: Hospital.HPP)
  end

	it 'without name' do
		@patient.name = nil
		fill_patient_fields
		click_button(class: 'btn-outline-primary')
		expect(find(class: 'error').text).to eq "Nome não pode ficar em branco"
	end

	it 'without birth_date' do
		@patient.birth_date = nil
		fill_patient_fields
		click_button(class: 'btn-outline-primary')
		expect(find(class: 'error').text).to eq "Data de nascimento não pode ficar em branco"
	end

	it 'without medical_record' do
		@patient.medical_record = nil
		fill_patient_fields
		click_button(class: 'btn-outline-primary')
		expect(find(class: "error", match: :first).text).to eq "Prontuário médico não pode ficar em branco."
	end

	it 'without mother_name' do
		@patient.mother_name = nil
		fill_patient_fields
		click_button(class: 'btn-outline-primary')
		expect(find(id: 'success-warning').text).to eq I18n.t :new_patient_success
	end

	it 'without hospital' do
		@patient.hospital = nil
		fill_patient_fields
		click_button(class: 'btn-outline-primary')
		expect(find(id: 'success-warning').text).to eq I18n.t :new_patient_success
	end

	it "without observations" do
		@patient.observations = nil
		fill_patient_fields
		click_button(class: 'btn-outline-primary')
		expect(find(id: 'success-warning').text).to eq I18n.t :new_patient_success
	end

	it 'duplicated name, mother_name, birth_date and hospital', js: false do
		duplicated = Patient.create({
			name: @patient.name,
			birth_date: @patient.birth_date,
			mother_name: @patient.mother_name,
			hospital: @patient.hospital,
			medical_record: Faker::Number.number(digits: 8).to_s
		})
		fill_patient_fields
		click_button(class: 'btn-outline-primary')
		expect(find(class: 'error').text).to eq "Nome já está em uso"
	end

	it 'with duplicated medical_record and hospital' do
		duplicated = Patient.create({
			name: Faker::Name.name,
			birth_date: Faker::Date.between(from: 12.years.ago, to: Date.today),
			mother_name: Faker::Name.name,
			hospital: @patient.hospital,
			medical_record: @patient.medical_record
		})
		fill_patient_fields
		click_button(class: 'btn-outline-primary')
		expect(find(class: 'error').text).to eq "Prontuário médico já está em uso"
	end

end
