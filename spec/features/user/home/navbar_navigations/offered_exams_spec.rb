require 'rails_helper'

RSpec.feature "User::Home::NavbarNavigations::OfferedExams", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    imunofeno_user_do_login
    click_link 'offered-exam-dropdown'
  end

  it "new" do
    click_link 'new-offered-exam'
    expect(page).to have_current_path new_offered_exam_path
  end

  it "search" do
    click_link 'offered-exams'
    expect(page).to have_current_path offered_exams_path
  end

end
