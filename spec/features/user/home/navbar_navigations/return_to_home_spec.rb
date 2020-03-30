require 'rails_helper'

RSpec.feature "User::Home::NavbarNavigations::ReturnToHomes", type: :feature do
  include UserLogin

  it "return to home" do
    Rails.application.load_seed
    biomol_user_do_login
    click_link 'patient-dropdown'
    click_link 'new-patient'
    expect(page).to have_current_path new_patient_path
    click_link 'home-link'
    expect(page).to have_current_path home_path
  end

end
