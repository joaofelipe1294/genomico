require 'rails_helper'
require 'helpers/attendance'
require 'helpers/user'

RSpec.feature "User::Workflow::Reports", type: :feature, js: true do

  before :each do
    Rails.application.load_seed
    create_attendance
    imunofeno_user_do_login
    click_link class: 'attendance-code', match: :first
    click_button id: 'exam_nav'
    @first_exam =  @attendance.exams
                              .joins(:offered_exam)
                              .where("offered_exams.field_id = ?", Field.IMUNOFENO.id)
                              .order("offered_exams.name ASC").first
    click_button id: 'sample_nav'
    click_link class: 'new-internal-code', match: :first
    click_button id: 'exam_nav'
    click_link class: 'start-exam', match: :first
    click_button id: 'btn-save'
    click_button id: 'exam_nav'
    visit current_path
    click_button 'exam_nav'
    click_link class: 'change-to-complete', match: :first
    page.driver.browser.switch_to.alert.accept
    visit current_path
    click_button id: 'exam_nav'
    click_link class: 'add-report', match: :first
    attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
    click_button id: 'btn-save'
  end

  it "list exams with reports" do
    click_button id: 'report_nav'
    expect(find_all(class: 'report').size).to eq Exam.where(exam_status_kind: ExamStatusKind.COMPLETE).size
  end

end
