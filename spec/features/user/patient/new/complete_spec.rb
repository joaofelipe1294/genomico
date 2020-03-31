require 'rails_helper'

RSpec.feature "User::Patient::New::Completes", type: :feature do
  include PatientHelpers
  include UserLogin

  it 'complete patient' do
    Rails.application.load_seed
    @patient = build(:patient)
    biomol_user_do_login
    click_link id: "patient-dropdown"
    click_link id: "new-patient"
    fill_patient_fields
    click_button id: "btn-save"
    expect(page).to have_current_path new_attendance_path(patient: Patient.last)
    expect(find(id: 'success-warning').text).to eq "Paciente cadastrado com sucesso."
  end

end
