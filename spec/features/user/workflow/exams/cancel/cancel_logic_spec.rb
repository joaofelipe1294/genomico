require 'rails_helper'

RSpec.feature "User::Workflow::Exams::Cancel::CancelLogics", type: :feature, js: true do
  include AttendanceHelper
  include UserLogin

  before(:each) { Rails.application.load_seed }

  it "cancel exam waiting start" do
    attendance = create_raw_imunofeno_attendance
    imunofeno_user_do_login
    visit workflow_path(attendance, tab: 'exams')
    page.driver.browser.accept_confirm
    click_link class: "cancel-exam", match: :first
    expect(page).to have_current_path workflow_path(attendance, tab: 'exams')
    exam = attendance.exams.first.reload
    expect(exam.exam_status_kind).to eq ExamStatusKind.CANCELED
    expect(attendance.reload.status).to eq :complete.to_s
  end

  it "cancel with in progress exam" do
    attendance = create_in_progress_imunofeno_attendance
    attendance.exams << create(:exam)
    imunofeno_user_do_login
    visit workflow_path(attendance, tab: 'exams')
    page.driver.browser.accept_confirm
    click_link class: "cancel-exam", match: :first
    canceled_exams = attendance.exams.where(exam_status_kind: ExamStatusKind.CANCELED).size
    expect(canceled_exams).to eq 1
    expect(attendance.reload.status).to eq :progress.to_s
  end

end
