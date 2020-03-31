require 'rails_helper'

RSpec.feature "User::Workflow::Exams::Start::Imunofenos", type: :feature do
  include AttendanceHelper
  include UserLogin

  before :each do
    Rails.application.load_seed
    @attendance = create_raw_imunofeno_attendance
    imunofeno_user_do_login
    visit attendance_path(@attendance, {tab: "exams"})
  end

  it "start exam with internal code" do
    click_link id: "samples-nav"
    click_link class: "new-internal-code", match: :first
    click_link id: "exams-nav"
    click_link class: "start-exam", match: :first
    expect(page).to have_current_path start_exam_path(@attendance.exams.first)
    click_button id: "btn-save"
    expect(find(id: "success-warning").text).to eq "Status de exame alterado para Em andamento."
    expect(page).to have_current_path attendance_path(@attendance, {tab: 'exams'})
  end

  it "try start exam without internal code" do
    click_link class: "start-exam", match: :first
    expect(find(id: "without-sample")).to be_visible
  end

end
