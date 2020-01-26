require 'rails_helper'

RSpec.describe Suggestion, type: :model do

  before :each do
    Rails.application.load_seed
    create(:user, user_kind: UserKind.USER)
  end

  context "suggestion is invalid when" do

    context "without required values" do

      after(:each) { expect(@suggestion).to be_invalid }

      it "is invalid when has not a title" do
        @suggestion = build(:suggestion, title: "")
      end

      it "is invalid when has not a description" do
        @suggestion = build(:suggestion, description: "")
      end

      it "is invalid when without requester" do
        @suggestion = build(:suggestion, requester: nil)
      end

    end

    context "when using duplicated values" do

      it "is expected to be invalid when title is duplicated" do
        create(:suggestion, title: "Some title")
        second_suggestion = build(:suggestion, title: "Some title")
        expect(second_suggestion).to be_invalid
      end

    end

  end

end
