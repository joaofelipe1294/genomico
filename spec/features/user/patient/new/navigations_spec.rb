require 'rails_helper'

RSpec.feature "User::Patient::New::Navigations", type: :feature do
  include UserLogin

  context 'navigations' do

		it 'without login' do
			visit new_patient_path
			expect(page).to have_current_path root_path
			expect(find(id: 'danger-warning').text).to eq "Credenciais inválidas."
		end

		it 'after login' do
			Rails.application.load_seed
			imunofeno_user_do_login
			Hospital.create({name: 'Hospital Pequeno Príncipe'})
			visit new_patient_path
			expect(page).to have_current_path new_patient_path
		end

	end

end
