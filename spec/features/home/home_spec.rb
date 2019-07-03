require 'rails_helper'

RSpec.feature "Home_page", type: :feature, js: true do

	it 'visit home_page' do
		page.driver.browser.manage.window.resize_to(1920, 1080)
		visit('/')
		expect(page).to have_current_path('/')
	end

	it 'try login with wrong login / password' do
		visit('/')
		fill_in('login', with: 'John')
		fill_in('password', with: 'Doe')
		click_button('btn-login')
		text_message = find(id: 'danger-warning').text
		expect(text_message).to eq("Login ou senha inválidos.")
		expect(page).to have_current_path('/')
	end

	it 'login with correct user credentials ADMIN' do
	 	Rails.application.load_seed
		admin = create(:user, user_kind: UserKind.find_by({name: 'admin'}))
		visit('/')
		fill_in('login', with: admin.login)
		fill_in('password', with: admin.password)
		click_button('btn-login')
		expect(page).to have_current_path('/home_admin/index')
	end	

	it 'login with correct USER credential' do
		Rails.application.load_seed
		admin = create(:user, user_kind: UserKind.find_by({name: 'user'}))
		visit('/')
		fill_in('login', with: admin.login)
		fill_in('password', with: admin.password)
		click_button('btn-login')
		expect(page).to have_current_path('/home_user/index')
	end

end
