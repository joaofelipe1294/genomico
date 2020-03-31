require 'rails_helper'

RSpec.feature "User::Workflow::Samples::Biomol::EditSubsamples", type: :feature do
  include AttendanceHelper
  include UserLogin

  before(:each) { Rails.application.load_seed }

  it "edit-subsample count" do
    attendance = create_raw_biomol_attendance
    biomol_user_do_login
    visit attendance_path(attendance, tab: 'samples')
    expect(find_all(class: "edit-sample").size).to eq attendance.reload.samples.size
    expect(find_all(class: "edit-subsample").size).to eq attendance.reload.subsamples.size
  end

  it "should not sidplay in complete attendance" do
    attendance = create_complete_biomol_attendance
    biomol_user_do_login
    visit attendance_path(attendance, tab: 'samples')
    expect(find_all(class: "edit-subsample").size).to eq 0
  end

end
