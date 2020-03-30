require 'rails_helper'

def navigate_and_fill_user_fields
	admin_do_login
	click_link(id: 'user-dropdown')
	click_link(id: 'new-user')
	fill_in('user[name]', with: @new_user.name) if @new_user.name
	fill_in('user[login]', with: @new_user.login) if @new_user.login
	fill_in('user[password]', with: @new_user.password) if @new_user.password
	fill_in('user[password_confirmation]', with: @new_user.password) if @new_user.password
	select(I18n.t("enums.user.kinds.#{@new_user.kind}"), from: "user[kind]").select_option if @new_user.kind
	click_button(class: 'btn')
end

RSpec.feature "Admin", type: :feature do
	include UserLogin

	before(:each) { Rails.application.load_seed }

	it 'Correct New::User' do
		@new_user = build(:user, kind: :user)
		navigate_and_fill_user_fields
		expect(page).to have_current_path(home_path)
		success_message = find(id: 'success-warning').text
		expect(success_message).to eq("Usuário cadastrado com sucesso.")
	end

	it 'Correct New::Admin' do
		@new_user = build(:user, kind: :admin)
		navigate_and_fill_user_fields
		expect(page).to have_current_path(home_path)
		success_message = find(id: 'success-warning').text
		expect(success_message).to eq("Usuário cadastrado com sucesso.")
	end

	it 'without name', js: true do
		@new_user = build(:user, name: nil, kind: :admin)
		navigate_and_fill_user_fields
		expect(page).to have_current_path(new_user_path)
	end

	it 'without login', js: true do
		@new_user = build(:user, login: nil, kind: :admin)
		navigate_and_fill_user_fields
		expect(page).to have_current_path(new_user_path)
	end

	it 'without password', js: true do
		@new_user = build(:user, password: nil, kind: :admin)
		navigate_and_fill_user_fields
		expect(page).to have_current_path(new_user_path)
	end

	it 'duplicated login', js: true do
		correct = create(:user, kind: :user)
		@new_user = build(:user, login: correct.login, kind: :user)
		navigate_and_fill_user_fields
		error_message = find(class: 'error').text
		expect(error_message).to eq("Login já está em uso")
	end

end
