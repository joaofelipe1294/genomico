require 'rails_helper'

RSpec.feature "User::Logout::Logouts", type: :feature do
	include UserLogin

	it 'logout', js: false do
		Rails.application.load_seed
		imunofeno_user_do_login
		click_link(id: 'logout-link')
		expect(page).to have_current_path root_path
	end

end
