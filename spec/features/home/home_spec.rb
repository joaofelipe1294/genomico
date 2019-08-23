require 'rails_helper'

RSpec.feature "Home_page", type: :feature, js: false do

	it 'visit home_page' do
		visit(root_path)
		expect(page).to have_current_path(root_path)
	end

	it 'try login with wrong login / password' do
		visit(root_path)
		fill_in('login', with: 'John')
		fill_in('password', with: 'Doe')
		click_button('btn-login')
		text_message = find(id: 'danger-warning').text
		expect(text_message).to eq("Login ou senha inválidos.")
		expect(page).to have_current_path(root_path)
	end

	it 'login with correct user credentials ADMIN' do
	 	Rails.application.load_seed
		admin = create(:user, user_kind: UserKind.find_by({name: 'admin'}))
		visit(root_path)
		fill_in('login', with: admin.login)
		fill_in('password', with: admin.password)
		click_button('btn-login')
		expect(page).to have_current_path(home_admin_index_path)
	end

	it 'login with correct USER credential' do
		Rails.application.load_seed
		admin = create(:user, user_kind: UserKind.find_by({name: 'user'}))
		visit(root_path)
		fill_in('login', with: admin.login)
		fill_in('password', with: admin.password)
		click_button('btn-login')
		expect(page).to have_current_path(home_user_index_path)
	end

end
