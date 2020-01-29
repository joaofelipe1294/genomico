require 'rails_helper'

RSpec.feature "Admin::Suggestions::Shows", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    create(:user)
    create(:suggestion, current_status: :in_line)
    create(:suggestion, current_status: :development)
    create(:suggestion, current_status: :complete)
    create(:suggestion, current_status: :development)
    create(:suggestion, current_status: :canceled)
  end

  describe "when admin wants to see a suggestion" do
    before :each do
      admin_do_login
      visit suggestions_index_admin_path
    end

    context "when admin navigate to suggestions_index" do
      it "is expected to render show button" do
        expect(find_all(class: "show-suggestion").size).to match 5
      end
      context "when admin click show button" do
        it "is expected to be redirected to show_suggestion" do
          click_link class: "show-suggestion", match: :first
          expect(page).to have_current_path suggestion_path(Suggestion.all.last)
        end
      end
    end
  end

  describe "when user wants to see a suggestion" do

    before :each do
      biomol_user_do_login
      visit suggestions_path
    end

    context "when user navigate to suggestions_index" do
      it "is expected to render show button" do
        expect(find_all(class: "show-suggestion").size).to match 5
      end
      context "when user click show button" do
        it "is expected to be redirected to show_suggestion" do
          click_link class: "show-suggestion", match: :first
          expect(page).to have_current_path suggestion_path(Suggestion.all.last)
        end
      end
    end
  end

end
