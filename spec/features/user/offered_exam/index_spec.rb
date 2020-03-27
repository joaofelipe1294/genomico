require 'rails_helper'

RSpec.feature "User::OfferedExam::Indices", type: :feature do
  include UserLogin

  def navigate_to
    click_link id: "offered-exam-dropdown"
    click_link id: "offered-exams"
  end

  context "list verifications" do

    before :each do
      Rails.application.load_seed
      OfferedExam.all.delete_all
      imunofeno_user_do_login
    end

    it "check list with zero offered_exams" do
      navigate_to
      expect(find_all(class: "offered-exam").size).to eq 0
    end

    it "with one exam" do
      create(:offered_exam, field: Field.IMUNOFENO)
      navigate_to
      expect(find_all(class: "offered-exam").size).to eq 1
    end

    it "with three exam" do
      create(:offered_exam, field: Field.IMUNOFENO)
      create(:offered_exam, field: Field.IMUNOFENO)
      create(:offered_exam, field: Field.IMUNOFENO)
      navigate_to
      expect(find_all(class: "offered-exam").size).to eq 3
    end

  end

  context "disable and enable offered_exam", js: true do

    before :each do
      Rails.application.load_seed
      OfferedExam.all.delete_all
      imunofeno_user_do_login
    end

    it "disable" do
      page.driver.browser.accept_confirm
      create(:offered_exam)
      navigate_to
      click_link class: "disable-offered-exam", match: :first
      expect(page).to have_current_path offered_exams_path
      expect(find(id: "success-warning").text).to eq I18n.t :edit_offered_exam_success
    end

    it "enable" do
      create(:offered_exam, is_active: false)
      navigate_to
      click_link class: "enable-offered-exam", match: :first
      expect(page).to have_current_path offered_exams_path
      expect(find(id: "success-warning").text).to eq I18n.t :edit_offered_exam_success
    end

  end


end
