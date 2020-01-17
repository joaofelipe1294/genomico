require 'rails_helper'

RSpec.feature "User::OfferedExam::News", type: :feature do
  include UserLogin

  context "offered_exam validations" do

    before :each do
      Rails.application.load_seed
      imunofeno_user_do_login
      click_link id: "offered-exam-dropdown"
      click_link id: "new-offered-exam"
      fill_in "offered_exam[name]", with: "some name"
      select(Field.IMUNOFENO.name, from: "offered_exam[field_id]").select_option
      fill_in "offered_exam[refference_date]", with: "5"
      fill_in "offered_exam[mnemonyc]", with: "SOME"
    end

    it "complete" do
      click_button id: "btn-save"
      expect(page).to have_current_path offered_exams_path
      expect(find(id: "success-warning").text).to eq I18n.t :new_offered_exam_success
    end

    context "without data" do

      it "name" do
        fill_in "offered_exam[name]", with: ""
        click_button id: "btn-save"
        expect(page).to have_current_path offered_exams_path
        expect(find(class: "error", match: :first).text).to eq "Nome não pode ficar em branco"
      end

      it "refference_date" do
        fill_in "offered_exam[refference_date]", with: ""
        click_button id: "btn-save"
        expect(page).to have_current_path offered_exams_path
        expect(find(class: "error", match: :first).text).to eq "Tempo de execução (em dias) não pode ficar em branco"
      end

      it "mnemonyc" do
        fill_in "offered_exam[mnemonyc]", with: ""
        click_button id: "btn-save"
        expect(page).to have_current_path offered_exams_path
        expect(find(id: "success-warning").text).to eq I18n.t :new_offered_exam_success
      end

    end


  end

  context "duplicated cases" do

    before :each do
      Rails.application.load_seed
      imunofeno_user_do_login
      create(:offered_exam, name: "EXAME", field: Field.IMUNOFENO, mnemonyc: "EX")
      click_link id: "offered-exam-dropdown"
      click_link id: "new-offered-exam"
      fill_in "offered_exam[name]", with: "some name"
      select(Field.IMUNOFENO.name, from: "offered_exam[field_id]").select_option
      fill_in "offered_exam[refference_date]", with: "5"
      fill_in "offered_exam[mnemonyc]", with: "SOME"
    end

    it "name" do
      fill_in "offered_exam[name]", with: "EXAME"
      click_button id: "btn-save"
      expect(page).to have_current_path offered_exams_path
      expect(find(class: "error", match: :first).text).to eq "Nome já está em uso"
    end

    it "mnemonyc" do
      fill_in "offered_exam[mnemonyc]", with: "EX"
      click_button id: "btn-save"
      expect(page).to have_current_path offered_exams_path
      expect(find(class: "error", match: :first).text).to eq "Mnemônico já está em uso"
    end

  end

end
