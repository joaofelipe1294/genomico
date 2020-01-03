require 'rails_helper'

RSpec.feature "User::Patient::New::HppValidations", type: :feature do
  include UserLogin
  include ValidationChecks
  include PatientHelpers

  before :each do
    Rails.application.load_seed
    imunofeno_user_do_login
    click_link(id: 'patient-dropdown')
    click_link(id: 'new-patient')
    @patient = Patient.new({
      name: Faker::Name.name,
      mother_name: Faker::Name.name,
      birth_date: Faker::Date.between(from: 12.years.ago, to: Date.today),
      medical_record: Faker::Number.number(digits: 6).to_s,
      hospital: Hospital.HPP
    })
  end

  it 'without medical_record' do
    @patient.medical_record = nil
    fill_patient_fields
    click_button(class: 'btn-outline-primary')
    expect(find(class: 'error', match: :first).text).to eq "Prontuário médico não pode ficar em branco."
  end

  it 'without mother_name' do
    @patient.mother_name = nil
    fill_patient_fields
    click_button id: "btn-save"
    expect(find(id: 'success-warning').text).to eq "Paciente cadastrado com sucesso."
  end

end
