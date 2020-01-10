require 'rails_helper'

RSpec.feature "User::Workflow::Samples::Removes", type: :feature do
  include AttendanceHelper
  include UserLogin

  before :each do
    Rails.application.load_seed
    @attendance = create_raw_imunofeno_attendance
    imunofeno_user_do_login
    visit workflow_path(@attendance, tab: 'samples')
  end

  it "check render of remove sample with only one sample in attendance" do
    expect(find_all(class: "remove-sample").size).to eq 1
  end

  it "should render remove sample option" do
    click_link class: "new-internal-code", match: :first
    expect(find_all(class: "remove-sample").size).to eq 0
  end

  it "remove sample", js: true do
    page.driver.browser.accept_confirm
    click_link class: "remove-sample"
    expect(page).to have_current_path workflow_path(@attendance, tab: 'samples')
    new_samples_size = @attendance.reload.samples.size
    expect(new_samples_size).to eq 0
  end

end
