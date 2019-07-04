require 'rails_helper'
require 'helpers/user'

def fill_offered_exam_fields
	fill_in("offered_exam[name]", with: @offered_exam.name) if @offered_exam.name
	select(@offered_exam.field.name, from: "offered_exam[field_id]").select_option if @offered_exam.field
	click_button(class: 'btn')
end

RSpec.feature "Admin::OfferedExam::News", type: :feature do
  
	before :each do
		Field.create([{name: 'Biomol'}, {name: 'Anatomia'}])
		admin_do_login
		click_link(id: 'offered-exam-dropdown')
		click_link(id: 'new-offered-exam')
	end

	context 'Correct cases' do

		it 'navigate to new offered_exam', js: false do
			@offered_exam = OfferedExam.new({name: 'Exame de teste', field: Field.last})
			fill_offered_exam_fields
			expect(OfferedExam.all.size).to eq 1
			expect(page).to have_current_path(home_admin_index_path)
			expect(find(id: 'success-warning').text).to eq("Exame ofertado cadastrado com sucesso.")
		end

	end

	context 'Validations' do

		it 'without name' do
			@offered_exam = OfferedExam.new({field: Field.last})
			fill_offered_exam_fields
			expect(find(class: 'error').text).to eq("Nome não pode ficar em branco")
		end

		it 'duplicated_name' do
			OfferedExam.create({name: 'duplicado', field: Field.last})
			@offered_exam = OfferedExam.new({name: 'duplicado', field: Field.first})
			fill_offered_exam_fields
			expect(find(class: 'error').text).to eq("Nome já está em uso")
		end

	end

end
