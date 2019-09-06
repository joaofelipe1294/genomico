require 'rails_helper'
require 'helpers/user'
require 'helpers/attendance'

def select_first_exam
  @first_exam =  @attendance.exams
                            .joins(:offered_exam)
                            .where("offered_exams.field_id = ?", Field.IMUNOFENO.id)
                            .order("offered_exams.name ASC").first
end

def generate_internal_code
  click_button id: 'sample_nav'
  click_link class: 'new-internal-code', match: :first
end

RSpec.feature "User::Workflow::Exmas", type: :feature do

  before :each do
    Rails.application.load_seed
  end

  context "exam validations", js: true do

    before :each do
      create_attendance
      imunofeno_user_do_login
      click_link class: 'attendance-code', match: :first
      click_button id: 'exam_nav'
    end

    it "check how many exams are listed" do
      expect(find_all(class: 'exam').size).to eq @attendance.exams.size
      expect(Exam.where(exam_status_kind: ExamStatusKind.WAITING_START).size).to eq @attendance.exams.size
    end

    context "exam verification" do

      before :each do
        select_first_exam
      end

      it "try start exam without internal code" do
        click_link class: 'start-exam', match: :first
        expect(page).to have_current_path start_exam_path(@first_exam)
        expect(find(id: 'exam-name').value).to eq @first_exam.offered_exam.name
        expect(page).to have_selector '#without-sample', visible: true
      end

      it "start exam" do
        generate_internal_code
        click_button id: 'exam_nav'
        click_link class: 'start-exam', match: :first
        click_button id: 'btn-save'
        expect(Exam.where(exam_status_kind: ExamStatusKind.IN_PROGRESS).size).to eq 1
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Em andamento."
      end

    end

    context "change exam status" do

      before :each do
        select_first_exam
        generate_internal_code
        click_button id: 'exam_nav'
        click_link class: 'start-exam', match: :first
        click_button id: 'btn-save'
        click_button id: 'exam_nav'
      end

      it "tecnical released" do
        click_link class: 'change-to-tecnical-released'
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.TECNICAL_RELEASED.name}."
        expect(Exam.where(exam_status_kind: ExamStatusKind.TECNICAL_RELEASED).size).to eq 1
      end

      it "in repeat" do
        click_link class: 'change-to-in-repeat'
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.IN_REPEAT.name}."
        expect(Exam.where(exam_status_kind: ExamStatusKind.IN_REPEAT).size).to eq 1
      end

      it "complete exam" do
        click_link class: 'change-to-complete'
        page.driver.browser.switch_to.alert.accept
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.COMPLETE.name}."
        expect(Exam.where(exam_status_kind: ExamStatusKind.COMPLETE).size).to eq 1
      end

    end

  end

end
