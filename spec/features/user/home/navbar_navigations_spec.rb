require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Home::NavbarNavigations", type: :feature do

  context "patient options" do

    before :each do
      user_do_login_with_seeds
      click_link 'patient-dropdown'
    end

    it "new" do
      click_link 'new-patient'
      expect(page).to have_current_path new_patient_path
    end

    it "search" do
      click_link 'patients'
      expect(page).to have_current_path patients_path
    end

  end

end
