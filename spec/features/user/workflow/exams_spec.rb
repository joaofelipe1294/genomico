require 'rails_helper'

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
  include DataGenerator
  include UserLogin

  before :each do
    Rails.application.load_seed
  end

  context "exam validations" do

    before :each do
      exam = build(:exam, offered_exam: OfferedExam.where(field: Field.IMUNOFENO).where(is_active: true).sample)
      sample = build(:sample, sample_kind: SampleKind.LIQUOR)
      @attendance = create(:attendance, exams: [exam], samples: [sample])
      imunofeno_user_do_login
      visit workflow_path(@attendance.id, {tab: 'exams'})
    end

      it "check how many exams are listed" do
        expect(find_all(class: 'exam').size).to eq 1
        expect(Exam.where(exam_status_kind: ExamStatusKind.WAITING_START).size).to eq 1
      end
  end

  context "exam report" do

    before :each do
      create_attendance
      imunofeno_user_do_login
      click_link class: 'attendance-code', match: :first
      click_button id: 'exam_nav'
      current_attendance = current_path
      select_first_exam
      generate_internal_code
      click_button id: 'exam_nav'
      click_link class: 'start-exam', match: :first
      click_button id: 'btn-save'
      click_button id: 'exam_nav'
      visit current_path
      click_button 'exam_nav'
      page.driver.browser.accept_confirm
      click_link class: 'change-to-complete', match: :first
      visit current_attendance
      click_button id: 'exam_nav'
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
      exam = Exam.where(exam_status_kind: ExamStatusKind.COMPLETE_WITHOUT_REPORT).first
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
        expect(find_all(class: 'change-to-partial-released').size).to eq Exam.where(exam_status_kind: ExamStatusKind.PARTIAL_RELEASED).size
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
        page.driver.browser.accept_confirm
        click_link class: 'change-to-complete', match: :first
        attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
        click_button id: 'btn-save'
        click_button id: 'report_nav'
        expect(find_all(class: 'complete-report').size).to eq 1
      end

    end

  end

end
