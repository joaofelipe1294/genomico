require 'rails_helper'

RSpec.feature "User::Home::Logouts", type: :feature do

  it "user logout" do
    Rails.application.load_seed
    user = User.create({
      login: Faker::Internet.username,
      password: Faker::Internet.password,
      name: Faker::Name.name,
      is_active: true,
      fields: [Field.IMUNOFENO],
      user_kind: UserKind.USER
    })
    visit root_path
    fill_in "login", with: user.login
    fill_in "password", with: user.password
    click_button id: 'btn-login'
    expect(page).to have_current_path home_user_index_path
    click_link id: 'logout-link'
    expect(page).to have_current_path root_path
  end

end
