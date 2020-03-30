require 'rails_helper'

def fill_in_fields
	fill_in('user[name]', with: @user.name) if @user.name
	fill_in('user[login]', with: @user.login) if @user.login
	select(@user.kind_name, from: "user[kind]").select_option if @user.kind
	click_button(id: 'btn-save')
end

RSpec.feature "Admin::EditUsers", type: :feature do
	include UserLogin

	context 'Correct cases' do

		before :each do
			Rails.application.load_seed
			create(:user, kind: :user)
			admin_do_login
			click_link(id: 'user-dropdown')
			click_link(id: 'users')
			click_link(class: 'edit-user', match: :first)
			@user = User.new({login: 'user_editado', name: 'nome_editado', kind: :user})
		end

		it 'edit user_name', js: false do
			fill_in_fields
			expect(page).to have_current_path(home_path)
		end

		it 'change user to admin', js: false do
			@user.kind = :admin
			fill_in_fields
			expect(page).to have_current_path(home_path)
			user = User.find_by({login: @user.login})
			expect(user.kind).to match "admin"
		end

	end

	context 'wrong cases' do

		before :each do
			Rails.application.load_seed
			create(:user, kind: :user)
			admin_do_login
			click_link(id: 'user-dropdown')
			click_link(id: 'users')
			click_link(class: 'edit-user', match: :first)
			@user = User.new({login: 'user_editado', name: 'nome_editado', kind: :user})
		end

		it 'without name', js: false do
			@user = User.new({login: Faker::Internet.username, name: "   "})
			fill_in_fields
			error_message = find(class: 'error').text
			expect(error_message).to eq("Nome não pode ficar em branco")
		end

		it 'without login', js: false do
			@user = User.new({name: Faker::Internet.username, login: "   "})
			fill_in_fields
			error_message = find(class: 'error').text
			expect(error_message).to eq("Login não pode ficar em branco")
		end

		it 'duplicated login', js: false do
			duplicated = User.create({
				name: 'Some name',
				login: 'jon.doe',
				password: '123123123',
				kind: :user
			})
			@user = User.new({login: duplicated.login})
			fill_in_fields
			error_message = find(class: 'error').text
			expect(error_message).to eq("Login já está em uso")
		end

	end

end
