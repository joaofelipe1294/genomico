require 'rails_helper'
require 'helpers/user'
require 'helpers/attendance'

RSpec.feature "User::Patient::Shows", type: :feature do

  before :each do
    Rails.application.load_seed
    create_attendance
    imunofeno_user_do_login
    click_link id: 'patient-dropdown'
    click_link id: 'patients'
    click_link class: 'patient-info', match: :first
  end

  it "show patient" do
    expect(page).to have_current_path patient_path(Patient.all.first)
  end

  it "edit patient" do
    click_link class: 'edit-patient', match: :first
    expect(page).to have_current_path edit_patient_path(Patient.all.first)
  end

  it "samples from patient" do
    click_link class: 'samples-from-patient', match: :first
    expect(page).to have_current_path samples_from_patient_path(Patient.all.first)
  end

  it "exams from patient" do
    click_link class: 'exams-from-patient', match: :first
    expect(page).to have_current_path exams_from_patient_path(Patient.all.first)
  end

  it "attendances from patient" do
    click_link class: 'attendances-from-patient', match: :first
    expect(page).to have_current_path attendances_from_patient_path(Patient.all.first)
  end

end
