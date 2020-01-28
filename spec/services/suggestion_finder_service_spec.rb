require 'rails_helper'

describe 'suggestion_finder_service' do

  before :each do
    Rails.application.load_seed
    create(:user)
    create(:suggestion, current_status: :in_line)
    create(:suggestion, current_status: :in_line)
    create(:suggestion, current_status: :evaluating)
    create(:suggestion, current_status: :development)
    create(:suggestion, current_status: :waiting_validation)
    create(:suggestion, current_status: :complete)
    create(:suggestion, current_status: :complete)
    create(:suggestion, current_status: :canceled)
  end

  context "when filter by in_progress" do
    it "is expected to return only not complete, canceled or in_line suggestions" do
      service = SuggestionFinderService.new 'in_progress'
      suggestions = service.call
      expect(suggestions.size).to match 3
    end
  end

  context "when filter by in_line" do
    it "is expected to return olnly in_line suggestions" do
      service = SuggestionFinderService.new 'in_line'
      suggestions = service.call
      expect(suggestions.size).to match 2
    end
  end

  context "when filter by complete" do
    it "is expected to return only complete suggestions" do
      service = SuggestionFinderService.new 'complete'
      suggestions = service.call
      expect(suggestions.size).to match 2
    end
  end

end
