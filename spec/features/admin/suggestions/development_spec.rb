require 'rails_helper'

RSpec.feature "Admin::Suggestions::Developments", type: :feature do
  include UserLogin

  describe "when admin change a suggestion current status do development" do

    before :each do
      Rails.application.load_seed
      create(:user, kind: :user)
      @suggestion = create(:suggestion)
      expect(@suggestion.reload.suggestion_progresses.size).to match 1
      admin_do_login
      visit suggestions_index_admin_path(kind: :in_line)
      click_link class: "change-to-development", match: :first
    end

    it "is expected to generate a new suggestion_progress" do
      expect(@suggestion.reload.suggestion_progresses.size).to match 3
    end

    it "is expected to generate progress with right user" do
      progress = @suggestion.reload.suggestion_progresses.last
      admin = User.where(kind: :admin).first
      expect(progress.responsible).to match admin
    end

    it "is expected to suggestion_progress new_status to be development" do
      progress = @suggestion.reload.suggestion_progresses.last
      expect(progress.new_status.to_sym).to match :development
    end

    it "is expected to save values" do
      expect(@suggestion.reload.start_at).to be
      expect(@suggestion.development?).to be_truthy
    end

    it "is expected to redirect to suggestion in development" do
      expect(page).to have_current_path suggestions_index_admin_path(kind: :in_progress)
    end

  end

end
