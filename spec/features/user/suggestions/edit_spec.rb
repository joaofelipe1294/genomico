require 'rails_helper'

RSpec.feature "User::Suggestion::Edits", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    @user = create(:user)
    biomol_user_do_login
  end

  describe "when user is going to edit Suggestion" do

    context "when suggestion is complete" do
      it "is expected not to render edit button" do
        suggestion = create(:suggestion, current_status: :complete, requester: @user)
        visit suggestions_path
        expect(find_all(class: "edit-suggestion").size).to match 0
      end
    end

    context "when suggestion isn't complete or canceled" do
      it "is expected to render edit button" do
        suggestion = create(:suggestion, requester: @user)
        visit suggestions_path
        expect(find_all(class: "edit-suggestion").size).to match 1
      end
    end

  end

  context "when editing suggestion" do

    before :each do
      @suggestion = create(:suggestion, requester: @user)
      @other_user = create(:user, user_kind: UserKind.USER)
      visit edit_suggestion_path(@suggestion)
    end

    context "when values are ok" do

      before :each do
        fill_in "suggestion[title]", with: "Other title"
        fill_in "suggestion[description]", with: "Other description"
        select(@other_user.login, from: "suggestion[requester_id]").select_option
        click_button id: "btn-save"
      end

      it "is expected to show success message" do
        expect(find(id: "success-warning").text).to match I18n.t :edit_suggestion_success
      end

      it "is expected to redirect to suggestions_path" do
        expect(page).to have_current_path suggestions_path
      end

      it "is expected to save values" do
        expect(@suggestion.reload.title).to match "Other title"
        expect(@suggestion.reload.description).to match "Other description"
        expect(@suggestion.reload.requester).to match @other_user
      end

    end

    context "when without required values" do

      before :each do
        fill_in "suggestion[title]", with: ""
        fill_in "suggestion[description]", with: ""
        click_button id: "btn-save"
      end

      it "is expected to display errors" do
        expect(find_all(class: "error").size).to eq 2
      end

      it "is expected to be redirected to suggestions_path" do
        expect(page).to have_current_path suggestion_path(@suggestion)
      end
    end

    context "when duplicated values" do

      before :each do
        other_suggestion = create(:suggestion, title: 'Other suggestion')
        fill_in "suggestion[title]", with: other_suggestion.title
        click_button id: "btn-save"
      end

      it "is expected to display errors" do
        expect(find_all(class: "error").size).to match 1
      end

      it "is expected to be redirected to suggestions_path" do
        expect(page).to have_current_path suggestion_path(@suggestion)
      end
    end

  end

end
