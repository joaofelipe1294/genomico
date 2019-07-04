require 'rails_helper'
require 'helpers/user'
require 'helpers/offered_exam'

RSpec.feature "Admin::OfferedExam::DisableAndEnableOfferedExams", type: :feature do

	before :each, js: true do
		setup_offered_exam
		admin_do_login
		click_link(id: 'offered-exam-dropdown')
		click_link(id: 'offered-exams')
		click_link(class: 'btn-outline-danger', match: :first)
		page.driver.browser.switch_to.alert.accept
	end

	it 'disable offered_exam', js: true do
		expect(OfferedExam.where(is_active: false).size).to eq 0
		expect(page).to have_current_path(home_admin_index_path)
		expect(find(id: 'success-warning').text).to eq("Exame desativado com sucesso.")
		expect(OfferedExam.where(is_active: false).size).to eq 1
	end

	it 'enable_exam', js: true do
		click_link(id: 'offered-exam-dropdown')
		click_link(id: 'offered-exams')
		click_link(class: 'btn-outline-secondary')
		expect(find(id: 'success-warning').text).to eq('Exame ativado com sucesso.')
	end

end