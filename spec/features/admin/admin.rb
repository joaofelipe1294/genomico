require 'rails_helper'

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


RSpec.feature "Admin", type: :feature, js: :false do
  
	context 'Navigation' do 

		it 'access admin home without login' do
			# page.driver.browser.manage.window.resize_to(1920, 1080)
			visit(home_admin_index_path)
			expect(page).to have_current_path(root_path)
			error_message = find(id: 'danger-warning').text
			expect(error_message).to eq("Credenciais inválidas.")	
		end

		it 'navigate to admin home' do
			admin_do_login
			click_link(id: 'user-dropdow')
			click_link(id: 'new-user')
			click_link(id: 'home-admin')
			expect(page).to have_current_path(home_admin_index_path)
		end

	end

	context 'Home#Functionalities' do

		it 'logout' do
			admin_do_login
			click_link('btn-logout')
			expect(page).to have_current_path(root_path)
		end

	end

	context 'User#cuntionalities' do

		it 'new user' do
			admin_do_login
			click_link(id: 'user-dropdow')
			click_link(id: 'new-user')
			expect(page).to have_current_path(new_user_path)
		end

		it 'new user without login' do
			visit(new_user_path)
			expect(page).to have_current_path(root_path)
			error_message = find(id: 'danger-warning').text
			expect(error_message).to eq("Credenciais inválidas.")
		end

		it 'create new user' do
			page.driver.browser.manage.window.resize_to(1920, 1080)
			Rails.application.load_seed
			user = User.new({
				login: Faker::Internet.username,
				password: '1234',
				name: Faker::Name.name,
				user_kind: UserKind.find_by({name: 'user'})
			})
			admin_do_login
			click_link(id: 'user-dropdow')
			click_link(id: 'new-user')
			fill_in('user[name]', with: user.name)
			fill_in('user[login]', with: user.login)
			fill_in('user[password]', with: user.password)
			fill_in('user[password_confirmation]', with: user.password)
			select(user.user_kind.name, from: "user[user_kind_id]").select_option
			click_button(class: 'btn')
			expect(page).to have_current_path(home_admin_index_path)
			success_message = find(id: 'success-warning').text
			expect(success_message).to eq("Usuário cadastrado com sucesso.")
		end

	end

end
