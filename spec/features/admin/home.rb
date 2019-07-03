require 'rails_helper'
require 'helpers/admin'

RSpec.feature "Admin::HomeNavigations", type: :feature, js: false do

	context 'Valid Navigations' do

		it 'New::User' do
			admin_do_login
			click_link(id: 'user-dropdow')
			click_link(id: 'new-user')
			expect(page).to have_current_path(new_user_path)
		end

		it 'Users::User' do
			admin_do_login
			click_link(id: 'user-dropdow')
			click_link(id: 'users')
			expect(page).to have_current_path('/users?kind=user')
		end

		it 'Users::Admin' do
			admin_do_login
			click_link(id: 'user-dropdow')
			click_link(id: 'admins')
			expect(page).to have_current_path('/users?kind=admin')
		end

		it 'User::New' do
			admin_do_login
			click_link(id: 'user-dropdow')
			click_link(id: 'all-users')
			expect(page).to have_current_path(users_path)
		end

		it 'OfferedExam::New' do
			admin_do_login
			click_link(id: 'offered-exam-dropdown')
			click_link(id: 'new-offered-exam')
			expect(page).to have_current_path(new_offered_exam_path)
		end

		it 'OffereExam::Find' do
			admin_do_login
			click_link(id: 'offered-exam-dropdown')
			click_link(id: 'offered-exams')
			expect(page).to have_current_path(offered_exams_path)
		end

	end

	context 'Invalid Navigations' do

		it 'New::User' do
			visit(new_user_path)
			expect(page).to have_current_path(root_path)
		end

		it 'Users::User' do
			visit('/users?kind=user')
			expect(page).to have_current_path(root_path)
		end

		it 'Users::Admin' do
			visit('/users?kind=admin')
			expect(page).to have_current_path(root_path)
		end

		it 'Users::All' do
			visit(users_path)
			expect(page).to have_current_path(root_path)
		end

		it 'OffereExam::New' do
			visit(new_offered_exam_path)
			expect(page).to have_current_path(root_path)
		end

		it 'OfferedExam::Find' do
			visit(offered_exams_path)
			expect(page).to have_current_path(root_path)
		end

	end

	context 'Functionalities' do

		it 'logout' do
			admin_do_login
			click_link('btn-logout')
			expect(page).to have_current_path(root_path)
		end

	end

end
