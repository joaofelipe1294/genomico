require 'rails_helper'

RSpec.feature "User::Workflow::Exam::Reports", type: :feature, js: true do
  include DataGenerator
  include UserLogin

  before :each do
    page.driver.browser.accept_confirm
    Rails.application.load_seed
    create_attendance
    imunofeno_user_do_login
    click_link class: 'attendance-code', match: :first
    attendance_path = "#{current_path}?tab=exams"
    click_button id: "sample_nav"
    click_link class: "new-internal-code", match: :first
    click_button id: 'exam_nav'
    click_link class: 'start-exam', match: :first
    click_button id: 'btn-save'
    click_button id: 'exam_nav'
    click_link class: 'change-to-complete', match: :first
    visit attendance_path
  end

  it "navigate to add report to exam" do
    expect(find_all(class: 'add-report').size).to eq Exam.where(exam_status_kind: ExamStatusKind.COMPLETE_WITHOUT_REPORT).size
    click_link class: 'add-report', match: :first
    exam = Exam.where(exam_status_kind: ExamStatusKind.COMPLETE_WITHOUT_REPORT).first
    expect(page).to have_current_path add_report_to_exam_path(exam)
  end

  it "add report to exam" do
    click_link class: 'add-report', match: :first
    attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
    click_button id: 'btn-save'
    expect(page).to have_current_path workflow_path(@attendance, {tab: "exams"})
    expect(find(id: 'success-warning').text).to eq I18n.t :add_report_to_exam_success
  end

  it "send without file" do
    click_link class: 'add-report', match: :first
    click_button id: 'btn-save'
    exam = Exam.where(exam_status_kind: ExamStatusKind.COMPLETE_WITHOUT_REPORT).first
    expect(page).to have_current_path add_report_to_exam_path(exam)
  end

  it "replace file" do
    click_link class: 'add-report', match: :first
    attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
    click_button id: 'btn-save'
    click_button id: 'exam_nav'
    click_link class: 'see-report', match: :first
    attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF_2.pdf"
    click_button id: 'btn-save'
    expect(page).to have_current_path workflow_path(@attendance, {tab: "exams"})
    expect(find(id: 'success-warning').text).to eq I18n.t :add_report_to_exam_success
    exam = Exam.where(exam_status_kind: ExamStatusKind.COMPLETE).first
    expect(exam.report_file_name).to eq "PDF_2.pdf"
  end

end
