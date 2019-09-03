require 'rails_helper'

RSpec.feature "User::Home::Logouts", type: :feature do

  it "user logout" do
    Rails.application.load_seed
    user = User.create({
      login: Faker::Internet.username,
      password: Faker::Internet.password,
      name: Faker::Name.name,
      is_active: true,
      fields: Field.IMUNOFENO # TODO: continuar daqui
    })
    visit root_path


  end

end
