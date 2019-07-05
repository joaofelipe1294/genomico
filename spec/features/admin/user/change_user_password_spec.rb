require 'rails_helper'
require 'helpers/admin'

def setup_change_password
	create_users
	admin_do_login
	click_link(id: 'user-dropdown')
	click_link(id: 'users')
	click_link(class: 'btn-outline-secondary', match: :first)
end

RSpec.feature "Admin::ChangeUserPasswords", type: :feature do
  
	it 'navigate to change password', js: false do
		setup_change_password
		expect(find(class: 'card-header').text).to eq("Alterar senha")
	end

	it 'change user_password', js: false do
		setup_change_password
		new_password = '123456789'
		fill_in('user_password', with: new_password)
		fill_in('user_password_confirmation', with: new_password)
		click_button(class: 'btn-outline-secondary')
		expect(page).to have_current_path(home_admin_index_path)
		message = find(id: 'success-warning').text
		expect(message).to eq("Senha alterada com sucesso.")
	end

	it 'distinct passwords', js: false do
		setup_change_password
		new_password = '123456789'
		fill_in('user_password', with: new_password)
		fill_in('user_password_confirmation', with: '1233')
		click_button(class: 'btn-outline-secondary')
		message = find(id: 'danger-warning').text
		expect(message).to eq("As senhas informadas não combinam.")
	end


end
