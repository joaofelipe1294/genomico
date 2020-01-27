require 'rails_helper'

RSpec.feature "User::Suggestions::Navigations", type: :feature do
  include UserLogin
  include ValidationChecks

  context "when navigating to suggestion views from home user" do

    before :each do
      Rails.application.load_seed
      biomol_user_do_login
      click_link id: "suggestions-dropdown"
    end

    it "is expected to be on new_suggestion with path param kind=new-feature" do
      click_link id: "new-feature"
      expect(page).to have_current_path new_suggestion_path(kind: 'new_feature')
    end

    it "is expected to be on new with path param kind=bug" do
      click_link id: "bug-report"
      expect(page).to have_current_path new_suggestion_path({kind: 'bug_report'})
    end

    it "is expected to be on new_suggestion with path param kind=new-improvement" do
      click_link id: "new-improvement"
      expect(page).to have_current_path new_suggestion_path(kind: 'feature_improvement')
    end

    it "is expected to go to index with path param inprogress" do
      click_link id: "suggestions-in-progress"
      expect(page).to have_current_path suggestions_path(kind: 'in-progress')
    end

    it "is expected to go to index with path param inprogress" do
      click_link id: "suggestions-complete"
      expect(page).to have_current_path suggestions_path(kind: 'complete')
    end

    it "is expected to go to index with user solicitations" do
      click_link id: "suggestions-user"
      expect(page).to have_current_path suggestions_path(from_user: true)
    end

  end

  it "is expected to be redirected to home when user is not logged in" do
    visit new_suggestion_path
    wrong_credentials_check
  end

end
