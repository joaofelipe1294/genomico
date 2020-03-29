require 'rails_helper'

RSpec.feature "User::Home::NavbarNavigations::Samples", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    biomol_user_do_login
    click_link 'samples-dropdown'
  end

  it "imunofeno" do
    click_link 'samples-imunofeno'
    expect(page).to have_current_path internal_codes_path(field: :imunofeno)
  end

  it "biomol" do
    click_link 'samples-biomol'
    expect(page).to have_current_path internal_codes_path(field: :biomol)
  end

  it "fish" do
    click_link 'samples-fish'
    expect(page).to have_current_path fish_internal_codes_path
  end

end
