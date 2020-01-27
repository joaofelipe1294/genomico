require 'rails_helper'

RSpec.feature "User::Suggestions::Cancels", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    create(:user)
    biomol_user_do_login
  end

  context "when user wants to cancel a suggestion" do

    context "when suggestion isn't complete or canceled" do

      before :each do
        @suggestion = create(:suggestion, current_status: :in_line)
        visit suggestions_path
      end

      it "is expected that the button who cancels it to be rendered" do
        expect(find_all(class: "cancel-suggestion").size).to match 1
      end

      context "when user click cancel button", js: true do

        before :each do
          page.driver.browser.accept_confirm
          click_link class: "cancel-suggestion", match: :first
        end

        it "is expected that use can cancel suggestion" do
          expect(page).to have_current_path suggestions_path
        end

        it "is expected that a new suggestion progress to be generated" do
          expect(@suggestion.reload.suggestion_progresses.size).to match 2
        end

        it "is expected that status change to canceled" do
          expect(@suggestion.reload.canceled?).to be_truthy
        end

      end

    end

  end

  context "when user navigates to suggestions view" do
    context "when suggestion is canceled" do
      it "is expected not to be rendered" do
        suggestion = create(:suggestion, current_status: :canceled)
        visit suggestions_path
        expect(find_all(class: "cancel-suggestion").size).to match 0
      end
    end

    context "when suggestion is complete" do
      it "is expected to not be rendered" do
        suggestion = create(:suggestion, current_status: :complete)
        visit suggestions_path
        expect(find_all(class: "cancel-suggestion").size).to match 0
      end
    end
  end

end
