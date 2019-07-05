require 'rails_helper'
require 'helpers/admin'

RSpec.feature "Admin::DisableAndEnableUsers", type: :feature do

	it 'disable_user', js: true do
		create_users
		admin_do_login
		click_link(id: 'user-dropdown')
		click_link(id: 'users')
		click_link(class: 'btn-outline-danger', match: :first)
		page.driver.browser.switch_to.alert.accept
		expect(page).to have_current_path(home_admin_index_path)
		expect(User.where(is_active: false).size).to eq(1)
	end

	it 'disable_user', js: true do
		create_users
		admin_do_login
		click_link(id: 'user-dropdown')
		click_link(id: 'users')
		click_link(class: 'btn-outline-danger', match: :first)
		page.driver.browser.switch_to.alert.accept
		click_link(id: 'user-dropdown')
		click_link(id: 'users')
		click_link(class: 'btn-outline-info', match: :first)
		expect(page).to have_current_path(home_admin_index_path)
		success_message = find(id: 'success-warning').text
		expect(success_message).to eq("Usuário reativado com sucesso.")
	end

end