require 'rails_helper'

RSpec.feature "User::OfferedExam::Edits", type: :feature do
  include UserLogin

  def navigate_to
    click_link id: "offered-exam-dropdown"
    click_link id: "offered-exams"
    click_link class: "edit-offered-exam", match: :first
  end

  context "Edit offered exam" do

    before :each do
      Rails.application.load_seed
      OfferedExam.all.delete_all
      create(:offered_exam, mnemonyc: "SOME", name: "Some name", field: Field.IMUNOFENO)
      imunofeno_user_do_login
      navigate_to
    end

    it "correct edition" do
      fill_in "offered_exam[name]", with: "New name"
      select(Field.BIOMOL.name, from: "offered_exam[field_id]").select_option
      fill_in "offered_exam[refference_date]", with: "15"
      fill_in "offered_exam[mnemonyc]", with: "SOME"
      click_button id: "btn-save"
      expect(page).to have_current_path offered_exams_path
      expect(find(id: "success-warning").text).to eq I18n.t :edit_offered_exam_success
    end

    it "edit without name" do
      fill_in "offered_exam[name]", with: ""
      click_button id: "btn-save"
      expect(page).to have_current_path offered_exam_path(OfferedExam.all.first)
      expect(find(class: "error", match: :first).text).to eq "Nome não pode ficar em branco"
    end

    it "without mnemonyc" do
      fill_in "offered_exam[mnemonyc]", with: ""
      click_button id: "btn-save"
      expect(page).to have_current_path offered_exams_path
      expect(find(id: "success-warning").text).to eq I18n.t :edit_offered_exam_success
    end

  end

  context "duplicated validations" do

    before :each do
      Rails.application.load_seed
      OfferedExam.all.delete_all
      create(:offered_exam, mnemonyc: "SOME", name: "Some name", field: Field.IMUNOFENO)
      create(:offered_exam, mnemonyc: "DC", name: "Zaniel Cormier", field: Field.IMUNOFENO)
      imunofeno_user_do_login
      navigate_to
    end

    it "duplicated name" do
      fill_in "offered_exam[name]", with: "Zaniel Cormier"
      click_button id: "btn-save"
      expect(find(class: "error", match: :first).text).to eq "Nome já está em uso"
    end

    it "duplicated mnemonyc" do
      fill_in "offered_exam[mnemonyc]", with: "DC"
      click_button id: "btn-save"
      expect(find(class: "error", match: :first).text).to eq "Mnemônico já está em uso"
    end

  end


end
