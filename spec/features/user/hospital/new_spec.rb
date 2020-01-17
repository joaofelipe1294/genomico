require 'rails_helper'

RSpec.feature "Admin::Hospital::News", type: :feature do
	include UserLogin

	before :each do
    Rails.application.load_seed
		biomol_user_do_login
		click_link(id: 'hospital-dropdown')
		click_link(id: 'new-hospital')
	end

	context 'Correct' do

		it 'correct', js: false do
			fill_in('hospital_name', with: Faker::Company.name)
			click_button id: 'btn-save'
			expect(page).to have_current_path hospitals_path
			expect(find(id: 'success-warning').text).to eq "Hospital cadastrado com sucesso."
		end

	end

	context 'Incorrect' do

		it 'without name' do
			click_button id: "btn-save"
			expect(find(class: 'error').text).to eq "Nome não pode ficar em branco"
		end

		it 'duplicated name' do
			Hospital.create({name: 'hospital'})
			fill_in('hospital_name', with: 'hospital')
			click_button id: "btn-save"
			expect(find(class: 'error').text).to eq "Nome já está em uso"
		end

	end

end
