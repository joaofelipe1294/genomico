require 'rails_helper'
require 'helpers/admin'
require 'helpers/offered_exam'

RSpec.feature "Admin::OfferedExam::Edits", type: :feature do

	before :each do
		admin_do_login
		setup_offered_exam
		Field.create({name: 'Cariotipagem'})
		click_link(id: 'offered-exam-dropdown')
		click_link(id: 'offered-exams')
		click_link(class: 'btn-outline-warning', match: :first)
	end

	context 'Correct' do

		it 'update name', js: false do
			fill_in('offered_exam_name', with: 'Nome EDITADO')
			click_button(class: 'btn')
			expect(page).to have_current_path home_admin_index_path
			expect(find(id: 'success-warning').text).to eq "Exame ofertado editado com sucesso."
		end

		it 'update field', js: false do
			field = Field.find_by({name: 'Cariotipagem'})
			select(field.name, from: "offered_exam_field_id").select_option
			click_button(class: 'btn')
			expect(find(id: 'success-warning').text).to eq "Exame ofertado editado com sucesso."
		end

	end

	context 'Incorrect' do

		it 'without name', js: false do
			fill_in('offered_exam_name', with: '   ')
			click_button(class: 'btn')
			expect(find(class: 'error', match: :first).text).to eq "Nome não pode ficar em branco"
		end

		it 'with duplicated name', js: false do
			OfferedExam.create({name: 'Nome', field: Field.last})
			fill_in('offered_exam_name', with: 'Nome')
			click_button(class: 'btn')
			expect(find(class: 'error', match: :first).text).to eq "Nome já está em uso"
		end


	end	

end
