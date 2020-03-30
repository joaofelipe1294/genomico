require 'rails_helper'

RSpec.feature "User::Home::Logouts", type: :feature do
  include UserLogin

  it "user logout" do
    Rails.application.load_seed
    biomol_user_do_login
    expect(page).to have_current_path home_path
    click_link id: 'logout-link'
    expect(page).to have_current_path root_path
  end

end
