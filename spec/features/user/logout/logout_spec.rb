require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Logout::Logouts", type: :feature do
	include UserLogin

	it 'logout', js: false do
		# user_do_login
		Rails.application.load_seed
		imunofeno_user_do_login
		click_link(id: 'logout-link')
		expect(page).to have_current_path root_path
	end

end
