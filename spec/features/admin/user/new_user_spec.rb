require 'rails_helper'

# def navigate_to_new_user
# 	click_link(id: 'user-dropdown')
# 	click_link(id: 'new-user')
# end

def navigate_and_fill_user_fields
	admin_do_login
	click_link(id: 'user-dropdown')
	click_link(id: 'new-user')
	fill_in('user[name]', with: @new_user.name) if @new_user.name
	fill_in('user[login]', with: @new_user.login) if @new_user.login
	fill_in('user[password]', with: @new_user.password) if @new_user.password
	fill_in('user[password_confirmation]', with: @new_user.password) if @new_user.password
	select(@new_user.user_kind.name, from: "user[user_kind_id]").select_option if @new_user.user_kind
	click_button(class: 'btn')
end

RSpec.feature "Admin", type: :feature do
	include UserLogin

	before(:each) { Rails.application.load_seed }

	it 'Correct New::User' do
		@new_user = build(:user, user_kind: UserKind.USER)
		navigate_and_fill_user_fields
		expect(page).to have_current_path(home_admin_index_path)
		success_message = find(id: 'success-warning').text
		expect(success_message).to eq("Usuário cadastrado com sucesso.")
	end

	it 'Correct New::Admin' do
		@new_user = build(:user, user_kind: UserKind.ADMIN)
		navigate_and_fill_user_fields
		expect(page).to have_current_path(home_admin_index_path)
		success_message = find(id: 'success-warning').text
		expect(success_message).to eq("Usuário cadastrado com sucesso.")
	end

	it 'without name', js: true do
		@new_user = build(:user, name: nil, user_kind: UserKind.ADMIN)
		navigate_and_fill_user_fields
		expect(page).to have_current_path(new_user_path)
	end

	it 'without login', js: true do
		@new_user = build(:user, login: nil, user_kind: UserKind.ADMIN)
		navigate_and_fill_user_fields
		expect(page).to have_current_path(new_user_path)
	end

	it 'without password', js: true do
		@new_user = build(:user, password: nil, user_kind: UserKind.ADMIN)
		navigate_and_fill_user_fields
		expect(page).to have_current_path(new_user_path)
	end

	it 'duplicated login', js: true do
		correct = create(:user, user_kind: UserKind.USER)
		@new_user = build(:user, login: correct.login, user_kind: UserKind.USER)
		navigate_and_fill_user_fields
		error_message = find(class: 'error').text
		expect(error_message).to eq("Login já está em uso")
	end

end
