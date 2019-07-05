def admin_do_login
	user_kind = UserKind.create({name: 'admin'})
	admin = User.create({
		login: 'admin',
		name: 'root',
		password: '1234',
		user_kind: user_kind 
	})
	visit(root_path)
	fill_in('login', with: admin.login)
	fill_in('password', with: admin.password)
	click_button('btn-login')
	expect(page).to have_current_path(home_admin_index_path)
end

def fill_user_fields
	fill_in('user[name]', with: @user.name) if @user.name
	fill_in('user[login]', with: @user.login) if @user.login
	fill_in('user[password]', with: @user.password) if @user.password
	fill_in('user[password_confirmation]', with: @user.password) if @user.password
	select(@user.user_kind.name, from: "user[user_kind_id]").select_option if @user.user_kind
	click_button(class: 'btn')
end

def create_users
	user_kind = UserKind.create({name: 'user'})
	User.create([
		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name}
	])
end
