require 'rails_helper'
require 'helpers/user'
require 'helpers/attendance'

RSpec.feature "User::Attendance::ExamValidations", type: :feature do

  it "Navigate to workflow and select exams tab", js: true do
    user_do_login
    create_attendance
    navigate_to_workflow
    click_button id: 'exam_nav'
    expect(page).to have_selector('#exams_tab', visible: true)
  end

end
