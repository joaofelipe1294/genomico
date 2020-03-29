require 'rails_helper'

RSpec.feature "Admin::Release::Confirms", type: :feature do
  include UserLogin

  it "confirma new release" do
    Rails.application.load_seed
    biomol_user_do_login
    create(:release)
    visit current_path
    expect(page).to have_selector('#release-message', visible: true)
    click_link id: "confirm-release"
    expect(page).not_to have_selector('#release-message')
    expect(page).to have_selector '#success-warning'
  end

end
