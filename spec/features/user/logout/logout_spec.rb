require 'rails_helper'

RSpec.feature "User::Logout::Logouts", type: :feature do

	it 'logout', js: false do
		user_kind = UserKind.create({name: 'user'})
		user = User.create({
			login: Faker::Internet.username,
			name: Faker::Name.name, 
			password: '1234',
			user_kind: user_kind
		})
		visit(root_path)
		fill_in('login', with: user.login)
		fill_in('password', with: user.password)
		click_button(class: 'btn')
		expect(page).to have_current_path home_user_index_path
		click_link(id: 'logout-link')
		expect(page).to have_current_path root_path
	end

end
