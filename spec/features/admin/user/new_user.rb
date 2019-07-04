require 'rails_helper'
require 'helpers/user'

def navigate_to_new_user
	click_link(id: 'user-dropdow')
	click_link(id: 'new-user')
end

RSpec.feature "Admin", type: :feature do

	before :each do
		Rails.application.load_seed
	end 

	context 'User#new_user' do

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

	context 'With duplicated_data' do

		it 'duplicated login', js: true do
			page.driver.browser.manage.window.resize_to(1920, 1080)
			correct = create(:user, user_kind: UserKind.find_by({name: 'user'}))
			@user = build(:user, login: correct.login, user_kind: UserKind.find_by({name: 'user'}))
			admin_do_login
			navigate_to_new_user
			fill_user_fields
			error_message = find(class: 'error').text
			expect(error_message).to eq("Login já está em uso")
		end

	end

end
