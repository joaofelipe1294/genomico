require 'rails_helper'

RSpec.feature "User::Home::NavbarNavigations::Patients", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    imunofeno_user_do_login
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
