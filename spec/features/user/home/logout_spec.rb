require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Home::Logouts", type: :feature do

  it "user logout" do
    user_do_login_with_seeds
    expect(page).to have_current_path home_user_index_path
    click_link id: 'logout-link'
    expect(page).to have_current_path root_path
  end

end
