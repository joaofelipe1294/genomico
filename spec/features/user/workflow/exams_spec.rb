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

def setup_partial_released
  create_attendance
  @attendance.exams.includes(:offered_exam).each do |exam|
    exam.delete if exam.offered_exam.field != Field.IMUNOFENO
  end
  imunofeno_user_do_login
  click_link class: 'attendance-code', match: :first
  click_button id: 'sample_nav'
  click_link class: 'new-internal-code', match: :first
  click_button id: 'exam_nav'
  click_link class: 'start-exam', match: :first
  click_button id: 'btn-save'
end

RSpec.feature "User::Workflow::Exams", type: :feature, js: true do

  before :each do
    Rails.application.load_seed
  end

  context "exam validations" do

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
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Em andamento."
      end

    end

    context "change exam status" do

      before :each do
        @attendance.exams.includes(:offered_exam).each do |exam|
          exam.delete if exam.offered_exam.field != Field.IMUNOFENO
        end
        generate_internal_code
        click_button id: 'exam_nav'
        click_link class: 'start-exam', match: :first
        click_button id: 'btn-save'
        click_button id: 'exam_nav'
      end

      it "tecnical released" do
        click_link class: 'change-to-tecnical-released'
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.TECNICAL_RELEASED.name}."
      end

      it "in repeat" do
        click_link class: 'change-to-in-repeat', match: :first
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.IN_REPEAT.name}."
      end

      it "complete exam" do
        visit current_path
        click_button 'exam_nav'
        click_link class: 'change-to-complete', match: :first
        page.driver.browser.switch_to.alert.accept
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.COMPLETE.name}."
      end

    end

    it "add exam to attendance" do
      click_link id: 'new-exam'
      select(Field.IMUNOFENO.name, from: "field").select_option
      select(OfferedExam.where(is_active: true).where(field: Field.IMUNOFENO).sample.name, from: "offered_exam_id").select_option
      click_button id: 'btn-save'
      expect(page).to have_current_path workflow_path(@attendance, {tab: "exams"})
      expect(find(id: 'success-warning').text).to eq I18n.t :new_exam_success
    end

    it "edit offered_exam" do
      new_offered_exam = OfferedExam.where(is_active: true).where(field: Field.IMUNOFENO).last
      click_link class: 'edit-exam', match: :first
      select(new_offered_exam.name, from: 'exam[offered_exam_id]').select_option
      click_button id: 'btn-save'
      click_button id: 'exam_nav'
      expect(new_offered_exam).not_to eq @first_exam
      expect(find(id: 'success-warning').text).to eq I18n.t :edit_exam_success
    end

    it "edit internal_code from exam" do
      generate_internal_code
      click_button id: 'sample_nav'
      generate_internal_code
      click_button id: 'exam_nav'
      click_link class: 'start-exam', match: :first
      click_button id: 'btn-save'
      click_button id: 'exam_nav'
      click_link class: 'edit-exam', match: :first
      select(@attendance.internal_codes.order(id: :desc).first.code, from: 'exam[internal_code]').select_option
      click_button id: 'btn-save'
      expect(find(id: 'success-warning').text).to eq I18n.t :edit_exam_success
    end

  end

  context "exam report" do

    before :each do
      create_attendance
      imunofeno_user_do_login
      click_link class: 'attendance-code', match: :first
      click_button id: 'exam_nav'
      select_first_exam
      generate_internal_code
      click_button id: 'exam_nav'
      click_link class: 'start-exam', match: :first
      click_button id: 'btn-save'
      click_button id: 'exam_nav'
      visit current_path
      click_button 'exam_nav'
      click_link class: 'change-to-complete', match: :first
      page.driver.browser.switch_to.alert.accept
      visit current_path
      click_button id: 'exam_nav'
    end

    it "navigate to add report to exam" do
      expect(find_all(class: 'add-report').size).to eq Exam.where(exam_status_kind: ExamStatusKind.COMPLETE).size
      click_link class: 'add-report', match: :first
      exam = Exam.where(exam_status_kind: ExamStatusKind.COMPLETE).first
      expect(page).to have_current_path add_report_to_exam_path(exam)
    end

    it "add report to exam" do
      click_link class: 'add-report', match: :first
      attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
      click_button id: 'btn-save'
      expect(page).to have_current_path workflow_path(@attendance, {tab: "exams"})
      expect(find(id: 'success-warning').text).to eq I18n.t :add_report_to_exam_success
    end

    it "send without file" do
      click_link class: 'add-report', match: :first
      click_button id: 'btn-save'
      exam = Exam.where(exam_status_kind: ExamStatusKind.COMPLETE).first
      expect(page).to have_current_path add_report_to_exam_path(exam)
    end

    it "replace file" do
      click_link class: 'add-report', match: :first
      attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
      click_button id: 'btn-save'
      click_button id: 'exam_nav'
      click_link class: 'see-report', match: :first
      attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF_2.pdf"
      click_button id: 'btn-save'
      expect(page).to have_current_path workflow_path(@attendance, {tab: "exams"})
      expect(find(id: 'success-warning').text).to eq I18n.t :add_report_to_exam_success
      exam = Exam.where(exam_status_kind: ExamStatusKind.COMPLETE).first
      expect(exam.report_file_name).to eq "PDF_2.pdf"
    end

  end

  context "partial released" do

    it "navigate to partial released" do
      setup_partial_released
      expect(find_all(class: 'change-to-partial-released').size).to eq 1
    end

    context "form validations" do

      before :each do
        setup_partial_released
        click_link class: 'change-to-partial-released'
      end

      it "ok" do
        attach_file "exam[partial_released_report]", "#{Rails.root}/spec/support_files/PDF.pdf"
        click_button id: 'btn-save'
        expect(page).to have_current_path workflow_path(@attendance, {tab: 'exams'})
        expect(find_all('change-to-partial-released').size).to eq Exam.where(exam_status_kind: ExamStatusKind.PARTIAL_RELEASED).size
      end

      it "without pdf" do
        click_button id: 'btn-save'
        exam = Exam.find current_path.split('/')[2]
        expect(page).to have_current_path change_to_partial_released_path(exam)
      end

    end

    context "listed in report tab" do

      before :each do
        setup_partial_released
        click_link class: 'change-to-partial-released'
        attach_file "exam[partial_released_report]", "#{Rails.root}/spec/support_files/PDF.pdf"
        click_button id: 'btn-save'
      end

      it "partial released report" do
        click_button id: 'report_nav'
        expect(find_all(class: 'partial-released-report').size).to eq 1
      end

      it "complete report" do
        click_button id: 'report_nav'
        expect(find_all(class: 'partial-released-report').size).to eq 1
        click_button id: 'exam_nav'
        click_link class: 'start-exam', match: :first
        click_button id: 'btn-save'
        click_link class: 'change-to-complete', match: :first
        page.driver.browser.switch_to.alert.accept
        attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
        click_button id: 'btn-save'
        click_button id: 'report_nav'
        expect(find_all(class: 'complete-report').size).to eq 1
      end

    end

  end

end
