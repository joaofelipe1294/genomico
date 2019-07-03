require 'rails_helper'

RSpec.feature "Admin", type: :feature, js: :true do
  
	context 'Navigation' do 

		it 'access admin home without login' do
			page.driver.browser.manage.window.resize_to(1920, 1080)
			visit(home_admin_index_path)
			expect(page).to have_current_path(root_path)
			error_message = find(id: 'danger-warning').text
			expect(error_message).to eq("Credenciais inválidas.")	
		end

	end

	context 'Functionalities' do

		it 'logout' do
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
			click_link('btn-logout')
			expect(page).to have_current_path(root_path)
		end

	end

end
