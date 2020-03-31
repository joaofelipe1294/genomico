require 'rails_helper'

RSpec.feature "User::Workflow::Exams::Cancel::Displays", type: :feature do
  include AttendanceHelper
  include UserLogin

  before(:each) { Rails.application.load_seed }

  context "when cancel should be rendered" do

    after :each do
      imunofeno_user_do_login
      visit attendance_path(@attendance, tab: 'exams')
      expect(find_all(class: "cancel-exam").size).to eq 1
    end

    it "display on exams waiting to start" do
      @attendance = create_raw_imunofeno_attendance
    end

    it "display cancel option on exams in progress" do
      @attendance = create_in_progress_imunofeno_attendance
    end

  end

  context "when cancel shouldn't be displayed" do

    after :each do
      imunofeno_user_do_login
      visit attendance_path(@attendance, tab: 'exams')
      expect(find_all(class: "cancel-exam").size).to eq 0
    end

    it "coplete exam" do
      @attendance = create_in_progress_imunofeno_attendance
      @attendance.exams.first.update status: :complete

    end

    it "coplete exam" do
      @attendance = create_in_progress_imunofeno_attendance
      @attendance.exams.first.update status: :canceled
    end

  end

end
