require 'rails_helper'

RSpec.feature "User::Home::NavbarNavigations::WorkMaps", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    biomol_user_do_login
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
