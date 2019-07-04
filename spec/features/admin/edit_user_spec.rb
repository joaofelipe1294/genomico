require 'rails_helper'
require 'helpers/user'

def create_users
	user_kind = UserKind.create({name: 'user'})
	User.create([
		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name}
	])
end

def navigate_to_edit_user_page
	click_link(id: 'user-dropdown')
	click_link(id: 'users')
	click_link(class: 'edit-user', match: :first)
end

def setup
	create_users
	admin_do_login
	navigate_to_edit_user_page
end

RSpec.feature "Admin::EditUsers", type: :feature do

	context 'Correct cases' do

		it 'edit user_name', js: false do
			setup
			@user = User.new({login: 'user_editado', name: 'nome_editado'})
			fill_user_fields
			expect(page).to have_current_path(home_admin_index_path)
		end

		it 'change user to admin', js: false do
			create_users
			admin_do_login
			admin_kind = UserKind.create({name: 'admin'})
			navigate_to_edit_user_page
			@user = User.new({login: Faker::Internet.username, name: Faker::Name.name, user_kind: admin_kind})
			fill_user_fields
			expect(page).to have_current_path(home_admin_index_path)
			user_kind = User.find_by({login: @user.login}).user_kind
			expect(user_kind.name).to eq('admin')
		end

	end

	context 'wrong cases' do

		it 'without name', js: false do
			setup
			@user = User.new({login: Faker::Internet.username, name: "   "})
			fill_user_fields
			error_message = find(class: 'error').text
			expect(error_message).to eq("Nome não pode ficar em branco")
		end

		it 'without login', js: false do
			setup
			@user = User.new({name: Faker::Internet.username, login: "   "})
			fill_user_fields
			error_message = find(class: 'error').text
			expect(error_message).to eq("Login não pode ficar em branco")
		end

		it 'duplicated login', js: false do
			setup
			duplicated = User.last
			@user = User.new({login: duplicated.login})
			fill_user_fields
			error_message = find(class: 'error').text
			expect(error_message).to eq("Login já está em uso")
		end

	end

end
