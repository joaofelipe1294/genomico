require 'rails_helper'

RSpec.feature "User::Exam::News", type: :feature do
  include UserLogin

  context "navigations" do

    before :each do
      Rails.application.load_seed
      create(:attendance)
    end

    it "navigate to" do
      visit new_exam_path(Attendance.all.sample)
      expect(page).to have_current_path root_path
      expect(find(id: 'danger-warning').text).to eq I18n.t :wrong_credentials_message
    end

    it "navigate with login" do
      imunofeno_user_do_login
      attendance = Attendance.all.sample
      visit new_exam_path(attendance)
      expect(page).to have_current_path new_exam_path(attendance)
    end

  end

  context "form validations" do

    before :each do
      Rails.application.load_seed
      @attendance = create(:attendance)
      imunofeno_user_do_login
      visit new_exam_path @attendance
    end

    it "check correct field selected", js: true do
      expect(page).to have_select(name: "field", selected: Field.IMUNOFENO.name)
    end

    it "verify if attendance id is correct" do
      expect(find(id: "exam_attendance_id", visible: false).value.to_i).to eq @attendance.id
    end

    it "create new exam same user field" do
      exam_that_will_be_selected = OfferedExam.where(field: Field.IMUNOFENO).where(is_active: true).order(name: :asc).last
      select(exam_that_will_be_selected.name, from: "exam[offered_exam_id]").select_option
      click_button id: 'btn-save'
      expect(page).to have_current_path(workflow_path(@attendance), ignore_query: true)
      expect(find(id: 'success-warning').text).to eq I18n.t :new_exam_success
    end

  end

end
