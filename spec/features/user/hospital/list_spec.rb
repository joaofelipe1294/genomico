require 'rails_helper'

RSpec.feature "Admin::Hospital::Lists", type: :feature do
	include UserLogin

	it 'list 3 hospitals' do
		Rails.application.load_seed
		Hospital.create([
			{name: Faker::Company.name},
			{name: Faker::Company.name},
			{name: Faker::Company.name}
		])
		biomol_user_do_login
		click_link(id: 'hospital-dropdown')
		click_link(id: 'hospitals')
		expect(find_all(class: 'hospital').size).to eq 3 + 1 # +1 devido ao HPP estar nas seeds
	end

end
