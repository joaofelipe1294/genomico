require 'rails_helper'
require 'helpers/user'

def navigate_to_exams_page
	click_link(id: 'offered-exam-dropdown')
	click_link(id: 'offered-exams')
end

RSpec.feature "Admin::OfferedExam::FindExams", type: :feature do
  
	before :each do
		Field.create([{name: 'Biomol'}, {name: 'Imunofeno'}, {name: 'Anatomia'}])
		OfferedExam.create([
			{name: 'Primeiro Exame', field: Field.order(name: :desc).first},
			{name: 'Algum exame complicado', field: Field.order(name: :desc).first},
			{name: 'Exame bem simples', field: Field.order(name: :desc).last}
		])
		admin_do_login
		navigate_to_exams_page
	end

	it 'search_by_name', js: false do
		fill_in(id: 'name', with: 'Algum')
		click_button(id: 'btn-search-by-name')
		expect(page).to have_current_path("/offered_exams?utf8=✓&name=Algum")
		exam_name = find(class: 'name', match: :first).text
		expect(exam_name).to eq("Algum exame complicado")
	end

	it 'search by field' do
		offered_exam = OfferedExam.new({field: Field.order(name: :desc).first})
		select(offered_exam.field.name, from: "field").select_option
		click_button(id: 'btn-search-by-field')
		offered_exams_found = Field.order(name: :desc).first.offered_exams.size
		expect(offered_exams_found).to eq(offered_exam.field.offered_exams.size)
	end

end
