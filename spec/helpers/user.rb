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

def user_do_login_with_seeds field: nil
	Rails.application.load_seed
	field = Field.IMUNOFENO if field.nil?
	user = User.create({
		login: Faker::Internet.username,
		password: Faker::Internet.password,
		name: Faker::Name.name,
		is_active: true,
		fields: [field],
		user_kind: UserKind.USER
	})
	visit root_path
	fill_in "login", with: user.login
	fill_in "password", with: user.password
	click_button id: 'btn-login'
end

def imunofeno_user_do_login_with_seeds
	user_do_login_with_seeds field: Field.IMUNOFENO
end

def biomol_user_do_login_with_seeds
	user_do_login_with_seeds field: Field.BIOMOL
end

def imunofeno_user_do_login
	field = Field.IMUNOFENO if field.nil?
	@user = User.create({
		login: Faker::Internet.username,
		password: Faker::Internet.password,
		name: Faker::Name.name,
		is_active: true,
		fields: [field],
		user_kind: UserKind.USER
	})
	login
end

def biomol_user_do_login
	field = Field.BIOMOL if field.nil?
	@user = User.create({
		login: Faker::Internet.username,
		password: Faker::Internet.password,
		name: Faker::Name.name,
		is_active: true,
		fields: [field],
		user_kind: UserKind.USER
	})
	login
end

def login
	visit root_path
	fill_in "login", with: @user.login
	fill_in "password", with: @user.password
	click_button id: 'btn-login'
end
