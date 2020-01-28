require 'rails_helper'

RSpec.feature "User::Suggestions::Cancels", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    biomol_user_do_login
  end

  context "when user wants to cancel a suggestion" do

    context "when suggestion isn't complete or canceled" do

      before :each do
        user = User.where(user_kind: UserKind.USER).last
        @suggestion = create(:suggestion, current_status: :in_line, requester: user)
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

        it "is expected to suggestion_progress status to eq canceled" do
          progress = @suggestion.reload.suggestion_progresses.order(:id).last
          expect(progress.new_status.to_sym).to match :canceled
        end

        it "is expected to current user to be responsible for the action" do
          progress = @suggestion.reload.suggestion_progresses.order(:id).last
          expect(progress.responsible).to match User.all.last
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
