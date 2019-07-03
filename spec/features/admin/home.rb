require 'rails_helper'
require 'helpers/admin'

RSpec.feature "Admin::HomeNavigations", type: :feature do

	# context 'Navigations' do

	# end

	context 'Functionalities' do

		it 'logout' do
			admin_do_login
			click_link('btn-logout')
			expect(page).to have_current_path(root_path)
		end

	end

end
