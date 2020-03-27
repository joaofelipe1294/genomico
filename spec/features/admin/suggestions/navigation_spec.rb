require 'rails_helper'

RSpec.feature "Admin::Suggestions::Navigations", type: :feature do
  include UserLogin
  include ValidationChecks

  context "when admin is logged in" do

    before :each do
      Rails.application.load_seed
      admin_do_login
      click_link id: "suggestion-dropdown"
    end

    it "is expected to visit in_development suggestions" do
      click_link id: "suggestions-in-progress"
      expect(page).to have_current_path suggestions_path(kind: "in_progress")
    end

    it "is expected to visit in line suggestions" do
      click_link id: "suggestions-in-line"
      expect(page).to have_current_path suggestions_path(kind: "in_line")
    end

    it "is expected to visit complete suggestions" do
      click_link id: "suggestions-complete"
      expect(page).to have_current_path suggestions_path(kind: "complete")
    end

    it "is expected to visit in line suggestions" do
      click_link id: "all-suggestions"
      expect(page).to have_current_path suggestions_path
    end
  end

  context "when admin is not logged in" do
    it "is expected to be redirected to home" do
      visit suggestions_path
      wrong_credentials_check
    end
  end

end
