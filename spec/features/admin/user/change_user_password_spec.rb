require 'rails_helper'

RSpec.feature "Admin::ChangeUserPasswords", type: :feature do
	include UserLogin
	include DataGenerator

	before :each do
		Rails.application.load_seed
		generate_users
		admin_do_login
		click_link(id: 'user-dropdown')
		click_link(id: 'users')
		click_link(class: 'btn-outline-secondary', match: :first)
	end

	it 'navigate to change password' do
		expect(find(class: 'card-header').text).to eq("Alterar senha")
	end

	it 'change user_password' do
		new_password = '123456789'
		fill_in('user[password]', with: new_password)
		fill_in('user[password_confirmation]', with: new_password)
		click_button(class: 'btn-outline-secondary')
		expect(page).to have_current_path(home_path)
		message = find(id: 'success-warning').text
		expect(message).to eq("Usuário editado com sucesso.")
	end

	it 'distinct passwords' do
		new_password = '123456789'
		fill_in('user[password]', with: new_password)
		fill_in('user[password_confirmation]', with: '1233')
		click_button(class: 'btn-outline-secondary')
		message = find(id: 'danger-warning').text
		expect(message).to eq("Confirmação de senha não é igual a Senha")
	end

end
