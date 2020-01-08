require 'rails_helper'

RSpec.feature "User::Workflow::Exams::Start::Imunofenos", type: :feature do
  include AttendanceHelper
  include UserLogin

  it "start exam with internal code" do
    Rails.application.load_seed
    attendance = create_raw_imunofeno_attendance
    imunofeno_user_do_login
    visit workflow_path(attendance, {tab: "exams"})
    click_link id: "samples-nav"
    click_link class: "new-internal-code", match: :first
    click_link id: "exams-nav"
    
    # p Exam.all.sample
    # p ExamStatusKind.WAITING_START
    # puts page.html
    # click_link class: "start-exam", match: :first
  end

end
