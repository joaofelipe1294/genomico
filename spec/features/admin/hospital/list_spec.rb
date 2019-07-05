require 'rails_helper'
require 'helpers/user'

RSpec.feature "Admin::Hospital::Lists", type: :feature do

	it 'list 3 hospitals' do
		Hospital.create([
			{name: Faker::Company.name}, 
			{name: Faker::Company.name}, 
			{name: Faker::Company.name}
		])
		admin_do_login
		click_link(id: 'hospital-dropdown')
		click_link(id: 'hospitals')
		expect(find_all(class: 'hospital').size).to eq 3
	end

end
