require 'rails_helper'
require 'helpers/admin_helpers'

RSpec.feature "Admin", type: :feature, js: :true do
  
	context 'Navigation' do 

		

	end


	context 'User#funtionalities' do

		it 'new user without login' do
			visit(new_user_path)
			expect(page).to have_current_path(root_path)
			error_message = find(id: 'danger-warning').text
			expect(error_message).to eq("Credenciais inválidas.")
		end

		it 'create new user' do
			# page.driver.browser.manage.window.resize_to(1920, 1080)
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
