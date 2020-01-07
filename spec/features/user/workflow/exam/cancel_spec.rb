require 'rails_helper'

RSpec.feature "User::Workflow::Exam::Cancels", type: :feature, js: true do
  include UserLogin
  include AttendanceHelper
  include DataGenerator

  def setup
    Rails.application.load_seed
    @attendance = create_raw_imunofeno_attendance
    imunofeno_user_do_login
    click_link class: 'attendance-code', match: :first
    @exam = @attendance.exams.last
  end

  context "Canceled" do

    # before(:each) { setup }

    # after :each do
    #   visit current_path
    #   click_button id: "exam_nav"
    #   page.driver.browser.accept_confirm
    #   puts page.html
    #   # puts "======================================="
    #   # p ExamStatusKind.all
    #   # puts "======================================="
    #   click_link class: 'cancel-exam', match: :first
    #   expect(page).to have_current_path(workflow_path(@attendance), ignore_query: true)
    #   expect(find_all(class: "text-danger").size).to eq 1
    # end

    before :each do
      puts "================================"
      puts "before seed"
      p ExamStatusKind.all
      Rails.application.load_seed
      puts "after seed"
      p ExamStatusKind.all
      puts "================================"
      create_attendance
      attendance = Attendance.all.last
      attendance.exams.joins(:offered_exam).where.not("offered_exams.field_id = ?", Field.IMUNOFENO.id).delete_all
      Exam.all.sample.delete
      imunofeno_user_do_login
      click_link class: 'attendance-code', match: :first
      @exam = attendance.exams.last
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
      puts "\nIts time ..."
      # puts "****************************************"
      # puts "before seed"
      # p ExamStatusKind.all
      # puts "****************************************"
      # Rails.application.load_seed
      # puts "========================================"
      # puts "after seeding"
      # p ExamStatusKind.all
      # puts "========================================"
      # @in_progress_attendance = create_in_progress_imunofeno_attendance
      # p @in_progress_attendance
      # p @in_progress_attendance.valid?
      # @raw_attendance = create_raw_imunofeno_attendance
      # p @raw_attendance.valid?
      # p @raw_attendance
      # imunofeno_user_do_login
      # click_link class: 'attendance-code', match: :first
      # @exam = @attendance.exams.last
      # visit current_path
      # click_button id: "exam_nav"
      # page.driver.browser.accept_confirm
      # click_link class: 'cancel-exam', match: :first
      # expect(page).to have_current_path(workflow_path(@attendance), ignore_query: true)
      # expect(find_all(class: "text-danger").size).to eq 1
    end

    # it "cancel in progress" do
    #   @exam.update(exam_status_kind: ExamStatusKind.IN_PROGRESS)
    # end
    #
    # it "cancel in repeat" do
    #   @exam.update(exam_status_kind: ExamStatusKind.IN_REPEAT)
    # end
    #
    # it "partial released" do
    #   @exam.update(exam_status_kind: ExamStatusKind.PARTIAL_RELEASED)
    # end

  end

  # context "verify render" do
  #
  #   it "complete exam" do
  #     setup
  #     @exam.update(exam_status_kind: ExamStatusKind.COMPLETE)
  #     visit current_path
  #     click_button id: "exam_nav"
  #     expect(find_all(class: "cancel-exam").size).to eq 0
  #   end
  #
  # end

end
