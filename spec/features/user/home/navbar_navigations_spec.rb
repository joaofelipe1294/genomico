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
      expect(page).to have_current_path imunofeno_internal_codes_path
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

  context "work-map" do

    before :each do
      click_link 'work-map-dropdown'
    end

    it "new" do
      click_link 'new-work-map'
      expect(page).to have_current_path new_work_map_path
    end

    it "search" do
      click_link 'work-maps'
      expect(page).to have_current_path work_maps_path
    end

  end

  context "offered-exams" do

    before :each do
      click_link 'offered-exam-dropdown'
    end

    it "new" do
      click_link 'new-offered-exam'
      expect(page).to have_current_path new_offered_exam_path
    end

    it "search" do
      click_link 'offered-exams'
      expect(page).to have_current_path offered_exams_path
    end

  end

  context "hospitals" do

    before :each do
      click_link 'hospital-dropdown'
    end

    it "new" do
      click_link 'new-hospital'
      expect(page).to have_current_path new_hospital_path
    end

    it "search" do
      click_link 'hospitals'
      expect(page).to have_current_path hospitals_path
    end

  end

  context "indicators" do

    before :each do
      click_link 'indicators-dropdown'
    end

    it "exams-in-progress" do
      click_link 'exams-in-progress'
      expect(page).to have_current_path exams_in_progress_path
    end

    it "concluded-exams" do
      click_link 'concluded-exams'
      expect(page).to have_current_path concluded_exams_path
    end

    it "health-ensurances-relation" do
      click_link 'health-ensurances-relation'
      expect(page).to have_current_path health_ensurances_relation_path
    end

  end

  it "return to home" do
    click_link 'patient-dropdown'
    click_link 'new-patient'
    expect(page).to have_current_path new_patient_path
    click_link 'home-link'
    expect(page).to have_current_path home_user_index_path
  end

end
