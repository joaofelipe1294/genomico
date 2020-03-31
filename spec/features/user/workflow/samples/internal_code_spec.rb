require 'rails_helper'

RSpec.feature "User::Workflow::Samples::InternalCodes", type: :feature do
  include AttendanceHelper
  include UserLogin

  before :each do
    Rails.application.load_seed
    @attendance = create_raw_imunofeno_attendance
    imunofeno_user_do_login
    visit attendance_path(@attendance, tab: 'samples')
  end

  it "add imunofeno internal code" do
    expect(find_all(class: "internal-code").size).to eq 0
    click_link class: "new-internal-code", match: :first
    expect(page).to have_current_path attendance_path(@attendance, tab: 'samples')
    expect(find_all(class: "internal-code").size).to eq 1
  end

  it "remove imunofeno internal code", js: true do
    click_link class: "new-internal-code", match: :first
    page.driver.browser.accept_confirm
    click_link class: "remove-internal-code"
    expect(page).to have_current_path attendance_path(@attendance, tab: "samples")
    expect(find_all(class: "internal-code").size).to eq 0
  end

end
