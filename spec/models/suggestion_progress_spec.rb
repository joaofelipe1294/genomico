require 'rails_helper'

RSpec.describe SuggestionProgress, type: :model do

  before :each do
    Rails.application.load_seed
    create(:user)
  end

  context "creating a new suggestion_progress without required values" do

    after(:each) { expect(@suggestion_progress).to be_invalid }

    it "is expected to be invalid when it hasnt a suggestion" do
      @suggestion_progress = build(:suggestion_progress, suggestion: nil)
    end

    it "is expected to be invalid when without new_status" do
      create(:suggestion)
      @suggestion_progress = build(:suggestion_progress, new_status: nil)
    end

  end

  context "when creating a new suggestion" do

    before :each do
      @suggestion = create(:suggestion)
    end

    it "is expected to have old_status nil and new_status as in_line" do
      progress = @suggestion.reload.suggestion_progresses.first
      expect(progress.old_status).to be_nil
      expect(progress.new_status).to match :in_line.to_s
    end

  end

  context "when changing status a suggestion" do

    before :each do
      @second_user = create(:user, kind: :admin)
      @suggestion = create(:suggestion)
      @suggestion.change_status :development, @second_user
      @suggestion_progress = @suggestion.reload.suggestion_progresses.order(:created_at).last
    end

    it "is expected to generate a new suggestion_progress" do
      expect(@suggestion.reload.suggestion_progresses.size).to match 2
    end

    it "is expected to suggestion_progress has old_status AND new_status" do
      expect(@suggestion_progress.old_status.to_sym).to match :in_line
      expect(@suggestion_progress.new_status.to_sym).to match :deve
    end

    it "is expected to have a responsible" do
      expect(@suggestion_progress.responsible).to  match @second_user
    end


  end

end
