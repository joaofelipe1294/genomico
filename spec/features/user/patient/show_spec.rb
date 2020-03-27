require 'rails_helper'

RSpec.feature "User::Patient::Shows", type: :feature do
  include UserLogin
  include DataGenerator

  before :each do
    Rails.application.load_seed
    create_attendance
    imunofeno_user_do_login
    click_link id: 'patient-dropdown'
    click_link id: 'patients'
    click_link class: 'patient-info', match: :first
  end

  it "show patient" do
    expect(page).to have_current_path patient_path(Patient.last, patient: true)
  end

  it "edit patient" do
    click_link class: 'edit-patient', match: :first
    expect(page).to have_current_path edit_patient_path(Patient.last)
  end

  it "samples from patient" do
    click_link class: 'samples-from-patient', match: :first
    expect(page).to have_current_path patient_path(Patient.last, samples: true)
  end

  it "exams from patient" do
    click_link class: 'exams-from-patient', match: :first
    expect(page).to have_current_path patient_path(Patient.last, exams: true)
  end

  it "attendances from patient" do
    click_link class: 'attendances-from-patient', match: :first
    expect(page).to have_current_path patient_path(Patient.last, attendance: true)
  end

end
