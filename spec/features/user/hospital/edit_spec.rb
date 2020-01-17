require 'rails_helper'

RSpec.feature "Admin::Hospital::Edits", type: :feature do
	include UserLogin

	before :each do
		Rails.application.load_seed
		Hospital.create([
			{ name: Faker::Company.name },
			{ name: Faker::Company.name },
			{ name: Faker::Company.name }
		])
		imunofeno_user_do_login
		click_link(id: 'hospital-dropdown')
		click_link(id: 'hospitals')
		click_link(class: 'btn-outline-warning', match: :first)
	end

	context 'Correct update' do

		it 'update' do
			fill_in('hospital_name', with: Faker::Company.name)
			click_button id: "btn-save"
			expect(page).to have_current_path hospitals_path
			expect(find(id: 'success-warning').text).to eq "Hospital editado com sucesso."
		end

	end

	context 'Incorrect updates' do

		it 'without name' do
			fill_in('hospital_name', with: '   ')
			click_button id: "btn-save"
			expect(find(class: 'error').text).to eq "Nome não pode ficar em branco"
		end

		it 'duplicated' do
			hospital = Hospital.create({name: 'Copia'})
			fill_in('hospital_name', with: hospital.name)
			click_button id: "btn-save"
			expect(find(class: 'error').text).to eq "Nome já está em uso"
		end

	end

end
