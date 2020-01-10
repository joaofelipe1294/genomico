require 'rails_helper'

RSpec.feature "User::Home::NavbarNavigations::Indicators", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    biomol_user_do_login
    click_link 'indicators-dropdown'
  end

  it "exams-in-progress" do
    click_link 'exams-in-progress'
    expect(page).to have_current_path exams_in_progress_path
  end

  it "concluded-exams" do
    click_link 'concluded-exams'
    expect(page).to have_current_path concluded_exams_path
  end

  it "health-ensurances-relation" do
    click_link 'health-ensurances-relation'
    expect(page).to have_current_path health_ensurances_relation_path
  end

end
