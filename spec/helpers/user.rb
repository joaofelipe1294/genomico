def user_do_login
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
end


def do_login
	visit(root_path)
	fill_in('login', with: 'user')
	fill_in('password', with: '1234')
	click_button(class: 'btn')
	expect(page).to have_current_path home_user_index_path
end


def user_do_login_with_seeds
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
end
