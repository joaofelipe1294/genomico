require 'rails_helper'
require 'helpers/admin'

def navigate_to_new_user
	click_link(id: 'user-dropdow')
	click_link(id: 'new-user')
end

def fill_user_fields
	fill_in('user[name]', with: @user.name) if @user.name
	fill_in('user[login]', with: @user.login) if @user.login
	fill_in('user[password]', with: @user.password) if @user.password
	fill_in('user[password_confirmation]', with: @user.password) if @user.password
	select(@user.user_kind.name, from: "user[user_kind_id]").select_option if @user.user_kind
	click_button(class: 'btn')
end

RSpec.feature "Admin", type: :feature do

	before :all do
		Rails.application.load_seed
	end 

	context 'User#funtionalities' do

		it 'Correct New::User' do
			@user = build(:user, user_kind: UserKind.find_by({name: 'user'}))
			admin_do_login
			navigate_to_new_user
			fill_user_fields
			expect(page).to have_current_path(home_admin_index_path)
			success_message = find(id: 'success-warning').text
			expect(success_message).to eq("Usuário cadastrado com sucesso.")
		end

		it 'Correct New::Admin' do
			@user = build(:user, user_kind: UserKind.find_by({name: 'admin'}))
			admin_do_login
			navigate_to_new_user
			fill_user_fields
			expect(page).to have_current_path(home_admin_index_path)
			success_message = find(id: 'success-warning').text
			expect(success_message).to eq("Usuário cadastrado com sucesso.")
		end

		it 'without name', js: true do
			page.driver.browser.manage.window.resize_to(1920, 1080)
			@user = build(:user, name: nil, user_kind: UserKind.find_by({name: 'admin'}))
			admin_do_login
			navigate_to_new_user
			fill_user_fields
			expect(page).to have_current_path(new_user_path)
		end

		it 'without login', js: true do
			page.driver.browser.manage.window.resize_to(1920, 1080)
			@user = build(:user, login: nil, user_kind: UserKind.find_by({name: 'admin'}))
			admin_do_login
			navigate_to_new_user
			fill_user_fields
			expect(page).to have_current_path(new_user_path)
		end

		it 'without password', js: true do
			page.driver.browser.manage.window.resize_to(1920, 1080)
			@user = build(:user, password: nil, user_kind: UserKind.find_by({name: 'admin'}))
			admin_do_login
			navigate_to_new_user
			fill_user_fields
			expect(page).to have_current_path(new_user_path)
		end

	end

end
