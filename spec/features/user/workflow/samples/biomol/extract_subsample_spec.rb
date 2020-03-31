require 'rails_helper'

RSpec.feature "User::Workflow::Samples::Biomol::ExtractSubsamples", type: :feature do
  include AttendanceHelper
  include UserLogin

  before :each do
    Rails.application.load_seed
    @attendance = create_raw_biomol_attendance
    biomol_user_do_login
    visit attendance_path(@attendance, tab: 'samples')
  end

  it "check extract subsample option and count elements rendered" do
    expect(find_all(class: "sample").size).to eq 1
    expect(find_all(class: "subsample").size).to eq @attendance.subsamples.size
    expect(find_all(class: 'new-subsample').size).to eq 1
  end

  it "check new subsample navigation" do
    click_link class: "new-subsample", match: :first
    expect(page).to have_current_path new_subsample_path(sample: @attendance.samples.last.id)
  end

  it "extract new subsample" do
    old_subsamples_count = @attendance.subsamples.size
    old_internal_codes_count = @attendance.internal_codes.size
    click_link class: "new-subsample", match: :first
    click_button id: "btn-save"
    expect(page).to have_current_path attendance_path(@attendance, tab: 'samples')
    expect(find_all(class: "subsample").size).to eq old_subsamples_count + 1
    expect(find_all(class: "internal-code").size).to eq old_internal_codes_count + 1
  end


end
