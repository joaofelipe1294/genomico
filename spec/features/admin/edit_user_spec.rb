require 'rails_helper'
require 'helpers/user'

RSpec.feature "Admin::EditUsers", type: :feature do

	it 'edit user_name', js: false do
		user_kind = UserKind.create({name: 'user'})
		User.create([
			{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
			{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
			{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
			{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
			{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name}
		])
		admin_do_login
		click_link(id: 'user-dropdown')
		click_link(id: 'users')
		click_link(class: 'edit-user', match: :first)
		@user = User.new({login: 'user_editado', name: 'nome_editado'})
		fill_user_fields
		expect(page).to have_current_path(home_admin_index_path)
	end

end
