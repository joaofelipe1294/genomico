require 'rails_helper'
require 'helpers/user'

def fill_patient_fields
	fill_in(:patient_name, with: @patient.name) if @patient.name
	fill_in(:patient_mother_name, with: @patient.mother_name) if @patient.mother_name
	fill_in(:patient_birth_date, with: @patient.birth_date) if @patient.birth_date
	fill_in(:patient_medical_record, with: @patient.medical_record) if @patient.medical_record
	select(@patient.hospital.name, from: "patient[hospital_id]").select_option if @patient.hospital
	fill_in "patient[observations]", with: @patient.observations if @patient.observations
end

def patient_spec_setup
	user_do_login
	hospital = Hospital.create({ name: Faker::Company.name })
	click_link(id: 'patient-dropdown')
	click_link(id: 'new-patient')
	@patient = Patient.new({
		name: Faker::Name.name,
		mother_name: Faker::Name.name,
		birth_date: Faker::Date.between(from: 12.years.ago, to: Date.today),
		medical_record: Faker::Number.number(digits: 6).to_s,
		hospital: hospital,
		observations: Faker::Lorem.paragraph
	})
end


RSpec.feature "User::Patient::News", type: :feature do

	context 'correct' do

		it 'complete patient' do
			patient_spec_setup
			fill_patient_fields
			click_button(class: 'btn-outline-primary')
			expect(page).to have_current_path home_user_index_path
			expect(find(id: 'success-warning').text).to eq "Paciente cadastrado com sucesso."
		end

	end

	context 'Validations' do

		before :each do
			patient_spec_setup
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
			expect(find(id: 'success-warning').text).to eq "Paciente cadastrado com sucesso."
		end

		it 'without mother_name' do
			@patient.mother_name = nil
			fill_patient_fields
			click_button(class: 'btn-outline-primary')
			expect(find(id: 'success-warning').text).to eq "Paciente cadastrado com sucesso."
		end

		it 'without hospital' do
			@patient.hospital = nil
			fill_patient_fields
			click_button(class: 'btn-outline-primary')
			expect(find(id: 'success-warning').text).to eq "Paciente cadastrado com sucesso."
		end

		it "without observations" do
			@patient.observations = nil
			fill_patient_fields
			click_button(class: 'btn-outline-primary')
			expect(find(id: 'success-warning').text).to eq "Paciente cadastrado com sucesso."
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

	context "HPP validations" do

		it 'without medical_record', js: false do
			user_do_login
			hospital = Hospital.create({ name: "Hospital Pequeno Príncipe" })
			click_link(id: 'patient-dropdown')
			click_link(id: 'new-patient')
			@patient = Patient.new({
				name: Faker::Name.name,
				mother_name: Faker::Name.name,
				birth_date: Faker::Date.between(from: 12.years.ago, to: Date.today),
				medical_record: Faker::Number.number(digits: 6).to_s,
				hospital: hospital
			})
			@patient.medical_record = nil
			fill_patient_fields
			click_button(class: 'btn-outline-primary')
			expect(find(class: 'error', match: :first).text).to eq "Prontuário médico não pode ficar em branco."
		end

		it 'without mother_name', js: false do
			user_do_login
			hospital = Hospital.create({ name: "Hospital Pequeno Príncipe" })
			click_link(id: 'patient-dropdown')
			click_link(id: 'new-patient')
			@patient = Patient.new({
				name: Faker::Name.name,
				mother_name: Faker::Name.name,
				birth_date: Faker::Date.between(from: 12.years.ago, to: Date.today),
				medical_record: Faker::Number.number(digits: 6).to_s,
				hospital: hospital
			})
			@patient.mother_name = nil
			fill_patient_fields
			click_button(class: 'btn-outline-primary')
			expect(find(class: 'error', match: :first).text).to eq "Nome da mãe não pode ficar em branco."
		end

	end

	context 'navigations' do

		it 'without login' do
			visit new_patient_path
			expect(page).to have_current_path root_path
			expect(find(id: 'danger-warning').text).to eq "Credenciais inválidas."
		end

		it 'after login' do
			user_do_login
			visit new_patient_path
			expect(page).to have_current_path new_patient_path
		end

	end

end
