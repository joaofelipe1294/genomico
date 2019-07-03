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