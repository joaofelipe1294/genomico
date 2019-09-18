require 'rails_helper'
require 'helpers/user'
require 'helpers/attendance'

RSpec.feature "User::Workflow::WorkflowHeaders", type: :feature do

  before :each do
    Rails.application.load_seed
    create_attendance
  end

  context "information check" do

    before :each do
      imunofeno_user_do_login
      click_link class: 'attendance-code', match: :first
    end

    it "access workflow" do
      expect(page).to have_current_path workflow_path(@attendance)
    end

    it "patient name" do
      expect(find(id: 'patient-link').text).to eq @attendance.patient.name
    end

    it "redirect to patient page" do
      click_link id: 'patient-link'
      expect(page).to have_current_path patient_path(@attendance.patient)
    end

    it "check lis_code" do
      expect(find(id: 'lis-code').text).to eq @attendance.lis_code
    end

  end

  context "tab navigations", js: true do

    before :each do
      imunofeno_user_do_login
      click_link class: 'attendance-code', match: :first
    end

    it "attendance_tab" do
      click_button id: 'exam_nav'
      click_button id: 'attendance_nav'
      expect(page).to have_selector '#attendance_tab', visible: true
    end

    it "exams tab" do
      click_button id: 'exam_nav'
      expect(page).to have_selector '#exams_tab', visible: true
    end

    it "samples tab" do
      click_button id: 'sample_nav'
      expect(page).to have_selector '#sample_nav', visible: true
    end

    it "maps tab" do
      click_button id: 'work_map_nav'
      expect(page).to have_selector '#work_map_tab', visible: true
    end

    it "reports tab" do
      click_button id: 'report_nav'
      expect(page).to have_selector '#report_nav', visible: true
    end

    it "patien tab" do
      click_button id: 'patient_nav'
      expect(page).to have_selector '#patient_tab', visible: true
    end

  end

  it "visit page without login" do
    visit(workflow_path(@attendance))
    expect(page).to have_current_path root_path
    expect(find(id: 'danger-warning').text).to eq I18n.t :wrong_credentials_message
  end

end
