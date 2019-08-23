require 'rails_helper'
require 'helpers/attendance'
require 'helpers/user'

RSpec.feature "User::Attendance::PatientValidations", type: :feature do

  context "Patient tab", js: true do

    before :each do
      user_do_login
      create_attendance
      navigate_to_workflow
      click_button id: 'patient_nav'
    end

    it "navigate to patient tab" do
      expect(page).to have_selector('#patient_tab', visible: true)
    end

    it "edit patient observations" do
      fill_in 'patient[observations]', with: 'Aqui tem uma observação'
      click_button id: 'btn-save-patient'
      expect(find(id: 'success-warning').text).to eq "Paciente editado com sucesso."
    end

  end

end
