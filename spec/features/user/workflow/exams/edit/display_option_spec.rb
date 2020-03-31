require 'rails_helper'

RSpec.feature "User::Workflow::Exams::Edit::DisplayOptions", type: :feature do
  include AttendanceHelper
  include UserLogin

  before(:each) { Rails.application.load_seed }

  context "when edit option is ment to be displayed" do

    after :each do
      visit attendance_path(@attendance, tab: 'exams')
      expect(find_all(class: "edit-exam").size).to eq 1
    end

    it "display when exam is waiting to start" do
      @attendance = create_raw_imunofeno_attendance
      imunofeno_user_do_login
    end

    it "display when exam is in progress" do
      @attendance = create_in_progress_biomol_attendance
      biomol_user_do_login
    end

  end

  context "when display option should not be rendered" do

    after :each do
      visit attendance_path(@attendance, tab: 'exams')
      expect(find_all(class: "edit-exam").size).to eq 0
    end

    it "dont display when exam is complete" do
      @attendance = create_in_progress_imunofeno_attendance
      imunofeno_user_do_login
      exam = @attendance.exams.first
      exam.update status: :complete
    end

    it "dont display when exam was canceled" do
      @attendance = create_in_progress_biomol_attendance
      biomol_user_do_login
      exam = @attendance.exams.last
      exam.update status: :canceled
    end

  end

end
