require 'rails_helper'

RSpec.describe SuggestionProgress, type: :model do

  context "when creating a new suggestion" do

    before :each do
      Rails.application.load_seed
      create(:user)
      @suggestion = create(:suggestion)
    end

    it "is expected to have old_status nil and new_status as in_line" do
      progress = @suggestion.reload.suggestion_progresses.first
      expect(progress.old_status).to be_nil
      expect(progress.new_status).to match :in_line.to_s
    end

  end

end
