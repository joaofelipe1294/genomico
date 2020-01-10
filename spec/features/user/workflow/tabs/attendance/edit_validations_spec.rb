require 'rails_helper'

RSpec.feature "User::Workflow::Tabs::Attendance::EditValidations", type: :feature do
  include AttendanceHelper
  include UserLogin

  before :each do
    Rails.application.load_seed
    @attendance = create_raw_imunofeno_attendance
    imunofeno_user_do_login
    visit workflow_path(@attendance, {tab: 'attendance'})
  end

  it "without lis_code" do
    fill_in "attendance[lis_code]", with: ""
    click_button id: "btn-save"
    expect(find(id: "danger-warning").text).to eq "Código LisNet não pode ficar em branco"
    expect(page).to have_current_path workflow_path(@attendance, {tab: 'attendance'})
  end

  it "duplicated lis_code" do
    biomol_attendance = create_raw_biomol_attendance
    fill_in "attendance[lis_code]", with: biomol_attendance.lis_code
    click_button id: "btn-save"
    expect(find(id: "danger-warning").text).to eq "Código LisNet já está em uso"
    expect(page).to have_current_path workflow_path(@attendance, {tab: 'attendance'})
  end

end
