require 'rails_helper'

RSpec.feature "User::Indicators::ResponseTimes", type: :feature do
  include UserLogin

  context "navigations" do

    before :each do
      Rails.application.load_seed
      imunofeno_user_do_login
      click_link id: "indicators"
      click_link id: "response-time-dropdown"
    end

    it "pcr" do
      click_link id: "pcr"
      expect(page).to have_current_path response_time_path(OfferedExamGroup.PCR.id)
    end

    it "sequencing" do
      click_link id: "sequencing"
      expect(page).to have_current_path response_time_path(OfferedExamGroup.SEQUENCING.id)
    end

    it "ngs" do
      click_link id: "ngs"
      expect(page).to have_current_path response_time_path(OfferedExamGroup.NGS.id)
    end

    it "FISH" do
      click_link id: "fish"
      expect(page).to have_current_path response_time_path(OfferedExamGroup.FISH.id)
    end

    it "Imunofeno" do
      click_link id: "imunofeno"
      expect(page).to have_current_path response_time_path(OfferedExamGroup.IMUNOFENO.id)
    end

  end

  context "data validation" do

    def navigate_to
      click_link id: "indicators"
      click_link id: "response-time-dropdown"
      click_link id: "pcr"
    end

    before :each do
      Rails.application.load_seed
      imunofeno_user_do_login
    end

    it "without exams" do
      navigate_to
      expect(find(id: "patients-count").text).to eq 0.to_s
      expect(find(id: "exams-count").text).to eq 0.to_s
      expect(find(id: "total-in-time").text).to eq 0.to_s
      expect(find(id: "total-late").text).to eq 0.to_s
    end

  end


end
