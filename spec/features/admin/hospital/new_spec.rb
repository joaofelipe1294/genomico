require 'rails_helper'
require 'helpers/admin'

RSpec.feature "Admin::Hospital::News", type: :feature do

	before :each do
    Rails.application.load_seed
		admin_do_login
		click_link(id: 'hospital-dropdown')
		click_link(id: 'new-hospital')
	end

	context 'Correct' do

		it 'correct', js: false do
			fill_in('hospital_name', with: Faker::Company.name)
			click_button(class: 'btn')
			expect(page).to have_current_path(home_admin_index_path)
			expect(find(id: 'success-warning').text).to eq "Hospital cadastrado com sucesso."
		end

	end

	context 'Incorrect' do

		it 'without name' do
			click_button(class: 'btn')
			expect(find(class: 'error').text).to eq "Nome não pode ficar em branco"
		end

		it 'duplicated name' do
			Hospital.create({name: 'hospital'})
			fill_in('hospital_name', with: 'hospital')
			click_button(class: 'btn')
			expect(find(class: 'error').text).to eq "Nome já está em uso"
		end

	end

end
