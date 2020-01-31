require 'rails_helper'

RSpec.feature "User::Suggestions::Completes", type: :feature do
  include UserLogin

  describe "when user going to complete a suggestion" do

    before :each do
      Rails.application.load_seed
      biomol_user_do_login
      user = User.all.last
      @admin = User.where(kind: :admin).last
      @suggestion = create(:suggestion, requester: user)
      expect(@suggestion.reload.suggestion_progresses.size).to match 1
      @suggestion.change_status :evaluating, @admin
      expect(@suggestion.reload.suggestion_progresses.size).to match 2
      @suggestion.change_to_development @admin, 7
      expect(@suggestion.reload.suggestion_progresses.size).to match 3
      visit suggestions_path(kind: :in_progress)
    end

    context "when there are no suggestions waiting validation" do
      it "is expected to not render complete option" do
        expect(find_all(class: "complete-suggestion").size).to match 0
      end
    end

    context "when there are suggestions waiting validation" do

      before :each do
        @suggestion.change_status :waiting_validation, @admin
        expect(@suggestion.reload.suggestion_progresses.size).to match 4
        visit suggestions_path(kind: :in_progress)
      end

      it "is expected to render complete link" do
        expect(find_all(class: "complete-suggestion").size).to match 1
      end

      context "when click on complete button", js: true do

        before :each do
          page.driver.browser.accept_confirm
          click_link class: "complete-suggestion", match: :first
        end

        it "is expected to generate new progress" do
          expect(@suggestion.reload.suggestion_progresses.size).to match 5
        end

        it "is expected to progress new _status to be complete" do
          progress = @suggestion.reload.suggestion_progresses.last
          expect(progress.new_status.to_sym).to match :complete
        end

        it "is expected to has a finish date" do
          expect(@suggestion.reload.finish_date).to be
        end

        it "is expected to hava complete as current status" do
          expect(@suggestion.reload.complete?).to be_truthy
        end

      end
    end

  end

end
