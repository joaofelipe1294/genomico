require 'rails_helper'

RSpec.feature "User::Workflow::Samples::News", type: :feature do
  include AttendanceHelper
  include UserLogin

  before(:each) { Rails.application.load_seed }

  it "navigate to new sample page" do
    attendance = create_raw_biomol_attendance
    biomol_user_do_login
    visit workflow_path(attendance, tab: 'samples')
    expect(page).to have_selector("#new-sample")
    click_link id: "new-sample"
    expect(page).to have_current_path new_sample_path(attendance)
  end

  it "dont diplay button in progress attendance", js: true do
    attendance = create_in_progress_imunofeno_attendance
    imunofeno_user_do_login
    visit workflow_path(attendance, tab: 'exams')
    page.driver.browser.accept_confirm
    click_link class: "change-to-complete", match: :first
    attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
    click_button id: "btn-save"
    visit workflow_path(attendance, tab: 'samples')
    expect(attendance.reload.status).to eq :complete.to_s
    expect(page).not_to have_selector("#new-sample")
  end

  it "add new sample to attendance" do
    attendance = create_raw_biomol_attendance
    expect(attendance.samples.size).to eq 1
    biomol_user_do_login
    visit workflow_path(attendance, tab: 'samples')
    click_link id: 'new-sample'
    click_button id: "btn-save"
    expect(page).to have_current_path workflow_path(attendance, tab: 'samples')
    new_samples_size = attendance.reload.samples.size
    expect(new_samples_size).to eq 2
  end

end
