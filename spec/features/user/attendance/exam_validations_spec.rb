require 'rails_helper'
require 'helpers/user'
require 'helpers/attendance'

def navigate_to_exams_tab
  user_do_login
  create_attendance
  navigate_to_workflow
  click_button id: 'sample_nav'
  click_link id: 'btn-internal-code'
  click_button id: 'btn-save'
  click_button id: 'exam_nav'
end

def start_exam
  click_link id: 'start-exam'
  click_button class: 'btn-outline-primary'
end

RSpec.feature "User::Attendance::ExamValidations", type: :feature do

  it "Navigate to workflow and select exams tab", js: true do
    navigate_to_exams_tab
    expect(page).to have_selector('#exams_tab', visible: true)
  end

  it "Initiate exam", js: true do
    navigate_to_exams_tab
    start_exam
    expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Em andamento."
  end

  it "Change exam status to Liberado Técnico", js: true do
    navigate_to_exams_tab
    start_exam
    click_button id: 'exam_nav'
    click_link id: 'chnge-to-tecnical-released'
    expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Liberado técnico."
  end

  it "Change exam status to In repetition", js: true do
    navigate_to_exams_tab
    start_exam
    click_button id: 'exam_nav'
    click_link id: 'change-to-in-repetition'
    expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Em repetição."
  end

  it "Change exam status to concluded", js: true do
    navigate_to_exams_tab
    start_exam
    page.driver.browser.navigate.refresh
    click_button id: 'exam_nav'
    click_link id: 'change-exam-to-completed'
    page.driver.browser.switch_to.alert.accept
    expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Concluído."
  end

end
