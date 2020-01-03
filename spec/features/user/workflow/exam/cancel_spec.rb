require 'rails_helper'

RSpec.feature "User::Workflow::Exam::Cancels", type: :feature, js: true do
  include UserLogin
  include DataGenerator

  def get_exam
    attendance = Attendance.all.last
    exam = attendance.exams.first
    exam
  end

  def reload_constants
    Object.send(:remove_const, :ExamStatusKinds) if Module.const_defined?(:ExamStatusKinds)
    Object.send(:remove_const, :AttendanceStatusKinds) if Module.const_defined?(:AttendanceStatusKinds)
    load 'app/models/concerns/exam_status_kinds.rb'
    load 'app/models/concerns/attendance_status_kinds.rb'
  end

  context "Canceled" do

    before :each do
      Rails.application.load_seed
      reload_constants
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
      page.driver.browser.accept_confirm
      click_link class: 'cancel-exam', match: :first
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
      reload_constants
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
