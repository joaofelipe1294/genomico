require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Home::NavbarNavigations", type: :feature do

  before :each do
    user_do_login_with_seeds
  end

  context "patient options" do

    before :each do
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

  context "attendance_options" do

    before :each do
      click_link 'attendance-dropdown'
    end

    it "panel" do
      click_link 'attendance-panel'
      expect(page).to have_current_path panels_exams_path
    end

    it "search" do
      click_link 'attendance-search'
      expect(page).to have_current_path attendances_path
    end

  end

  context "samples" do

    before :each do
      click_link 'samples-dropdown'
    end

    it "imunofeno" do
      click_link 'samples-imunofeno'
      expect(page).to have_current_path internal_codes_path field_id: Field.IMUNOFENO
    end

    it "biomol" do
      click_link 'samples-biomol'
      expect(page).to have_current_path internal_codes_path field_id: Field.BIOMOL
    end

    it "fish" do
      click_link 'samples-fish'
      expect(page).to have_current_path internal_codes_path field_id: Field.FISH
    end

  end

end
