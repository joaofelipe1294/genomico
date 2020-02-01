require 'rails_helper'

RSpec.feature "User::Workflow::Exams::AddExams", type: :feature do
  include AttendanceHelper
  include UserLogin

  it "add same field exam", js: true do
    Rails.application.load_seed
    attendance = create_raw_imunofeno_attendance
    imunofeno_user_do_login
    visit workflow_path(attendance, tab: 'exams')
    click_link id: "new-exam"
    click_button id: "btn-save"
    expect(page).to have_current_path workflow_path(attendance, tab: 'exams')
    expect(find_all(class: "exam").size).to eq 2
    expect(attendance.reload.exams.size).to eq 2
  end

end
