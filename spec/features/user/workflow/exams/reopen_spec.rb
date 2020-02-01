require 'rails_helper'

RSpec.feature "User::Workflow::Exams::Reopens", type: :feature do
  include AttendanceHelper
  include UserLogin

  it "reopen exam", js: true do
    Rails.application.load_seed
    attendance = create_in_progress_biomol_attendance
    biomol_user_do_login
    visit workflow_path(attendance, tab: 'exams')
    page.driver.browser.accept_confirm
    click_link class: "change-to-complete"
    attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
    click_button id: "btn-save"
    page.driver.browser.accept_confirm
    click_link class: "reopen-exam", match: :first
    expect(attendance.reload.status).to eq :progress.to_s
    exam = attendance.exams.first.reload
    expect(exam.exam_status_kind).to eq ExamStatusKind.IN_PROGRESS
  end

end
