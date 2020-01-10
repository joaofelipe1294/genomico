require 'rails_helper'

RSpec.feature "User::Workflow::Samples::Edits", type: :feature do
  include AttendanceHelper
  include UserLogin

  it "edit sample from raw attendance" do
    Rails.application.load_seed
    attendance = create_raw_biomol_attendance
    biomol_user_do_login
    visit workflow_path(attendance, tab: 'samples')
    click_link class: "edit-sample", match: :first
    expect(page).to have_current_path edit_sample_path(attendance.samples.first)
    fill_in "sample[receipt_notice]", with: "Nova biservação"
    click_button id: "btn-save"
    expect(page).to have_current_path workflow_path(attendance, tab: 'samples')
    expect(find(id: "success-warning").text).to eq I18n.t :edit_sample_success
    sample = attendance.samples.first.reload
    expect(sample.receipt_notice).to eq "Nova biservação"
  end

end
