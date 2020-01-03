require 'rails_helper'

RSpec.feature "User::Home::NavbarNavigations::Hospitals", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    imunofeno_user_do_login
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
