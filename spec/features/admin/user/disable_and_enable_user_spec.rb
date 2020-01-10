require 'rails_helper'

RSpec.feature "Admin::DisableAndEnableUsers", type: :feature do
	include UserLogin
	include DataGenerator

	before :each do
		Rails.application.load_seed
		page.driver.browser.accept_confirm
		generate_users
		admin_do_login
		click_link(id: 'user-dropdown')
		click_link(id: 'users')
		click_link(class: 'btn-outline-danger', match: :first)
	end

	it 'disable_user', js: true do
		expect(page).to have_current_path home_admin_index_path
		expect(User.where(is_active: false).size).to eq(1)
	end

	it 'enable_user', js: true do
		click_link(id: 'user-dropdown')
		click_link(id: 'users')
		click_link(class: 'btn-outline-info', match: :first)
		expect(page).to have_current_path(home_admin_index_path)
		success_message = find(id: 'success-warning').text
		expect(success_message).to eq("Usuário reativado com sucesso.")
	end

end
