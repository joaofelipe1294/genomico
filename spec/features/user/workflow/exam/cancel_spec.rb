require 'rails_helper'
require 'helpers/attendance'
require 'helpers/user'

RSpec.feature "User::Workflow::Exam::Cancels", type: :feature, js: true do

  def get_exam
    attendance = Attendance.all.last
    exam = attendance.exams.first
    exam
  end

  context "Canceled" do

    before :each do
      Rails.application.load_seed
      create_attendance
      attendance = Attendance.all.last
      attendance.exams.joins(:offered_exam).where.not("offered_exams.field_id = ?", Field.IMUNOFENO.id).delete_all
      Exam.all.sample.delete
      imunofeno_user_do_login
      click_link class: 'attendance-code', match: :first
      @exam = get_exam
    end

    after :each do
      visit current_path
      click_button id: "exam_nav"
      click_link class: 'cancel-exam', match: :first
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_current_path(workflow_path(Attendance.all.last), ignore_query: true)
      expect(find_all(class: "text-danger").size).to eq 1
    end

    it "cancelar waiting to start" do
    end

    it "cancel in progress" do
      @exam.update(exam_status_kind: ExamStatusKind.IN_PROGRESS)
    end

    it "cancel in repeat" do
      @exam.update(exam_status_kind: ExamStatusKind.IN_REPEAT)
    end

    it "partial released" do
      @exam.update(exam_status_kind: ExamStatusKind.PARTIAL_RELEASED)
    end

  end

  context "verify render" do

    it "complete exam" do
      Rails.application.load_seed
      create_attendance
      attendance = Attendance.all.last
      attendance.exams.joins(:offered_exam).where.not("offered_exams.field_id = ?", Field.IMUNOFENO.id).delete_all
      Exam.all.sample.delete
      imunofeno_user_do_login
      click_link class: 'attendance-code', match: :first
      @exam = get_exam
      @exam.update(exam_status_kind: ExamStatusKind.COMPLETE)
      visit current_path
      click_button id: "exam_nav"
      expect(find_all(class: "cancel-exam").size).to eq 0
    end

  end

end
