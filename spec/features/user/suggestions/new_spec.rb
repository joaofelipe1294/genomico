require 'rails_helper'

RSpec.feature "User::Suggestions::News", type: :feature do
  include UserLogin

  describe "when creating a new feature request" do

    before :each do
      Rails.application.load_seed
      imunofeno_user_do_login
      visit new_suggestion_path(kind: "new_feature")
    end

    context "when params are ok" do

      before :each do
        suggestion = build(:suggestion)
        fill_in "suggestion[title]", with: suggestion.title
        fill_in "suggestion[description]", with: suggestion.description
        select(User.all.last.login, from: "suggestion[requester_id]").select_option
        click_button id: "btn-save"
        @suggestion = Suggestion.all.last
      end

      it "is expected to create a new suggestion" do
        expect(Suggestion.all.size).to match 1
      end

      it "is expected that the suggestion have a suggestion progress" do
        expect(@suggestion.suggestion_progresses.size).to match 1
      end

      it "is expected that suggestion status is in_line" do
        expect(@suggestion.in_line?).to be_truthy
      end

      it "is expected to be redirected to suggestions_path" do
        expect(page).to have_current_path suggestions_path
      end

      it "is expected to suggestion is a new_feature" do
        expect(@suggestion.new_feature?).to be_truthy
      end

    end

    context "when missing attributes" do

      before :each do
        click_button id: "btn-save"
      end

      it "is expected to not create suggestion" do
        expect(Suggestion.all.size).to match 0
      end

      it "is expected to be redirected to suggestions_path" do
        expect(page).to have_current_path suggestions_path
      end

      it "is expected to display error messages" do
        expect(find_all(class: "error").size).to match 2
      end

    end

  end

end
