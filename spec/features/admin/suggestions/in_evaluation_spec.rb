require 'rails_helper'

RSpec.feature "Admin::Suggestions::InEvaluations", type: :feature do
  include UserLogin

  describe "changing a suggestion from in_line to in-evaluation" do

    before :each do
      Rails.application.load_seed
      create(:user)
      @suggestion = create(:suggestion)
      admin_do_login
      visit suggestions_index_admin_path(kind: :in_line)
      expect(find_all(class: "suggestion").size).to match 1
      expect(find_all(class: "change-to-evaluating").size).to match 1
      click_link class: "change-to-evaluating", match: :first
    end

    it "is expected to generate a new suggestion_progress" do
      expect(@suggestion.reload.suggestion_progresses.size).to match 2
    end

    it "is expected to new suggestion_progress has evaluating status" do
      expect(@suggestion.reload.suggestion_progresses.last.new_status).to match :evaluating.to_s
    end


    it "is expected to change current_status to evaluating" do
      expect(@suggestion.reload.evaluating?).to be_truthy
    end

    it "is expected to be redirected to suggestions_index_admin_path" do
      expect(page).to have_current_path suggestions_index_admin_path
    end

  end

end
