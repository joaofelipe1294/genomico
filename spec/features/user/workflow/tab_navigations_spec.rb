require 'rails_helper'

RSpec.feature "User::Worflow::TabNavigations", type: :feature do
  include AttendanceHelper
  include UserLogin

  before :each do
    Rails.application.load_seed
    @attendance = create_raw_imunofeno_attendance
    imunofeno_user_do_login
  end

  it "navigate to workflow" do
    click_link class: "attendance-code"
    expect(page).to have_current_path workflow_path(@attendance, {tab: 'exams'})
  end

  it "go to attendance tab" do
    visit workflow_path(@attendance, {tab: 'exams'})
    click_link id: 'attendance-nav'
    expect(page).to have_current_path workflow_path(@attendance, {tab: 'attendance'})
  end

  it "go to exams tab" do
    visit workflow_path(@attendance, {tab: 'attendance'})
    click_link id: 'exams-nav'
    expect(page).to have_current_path workflow_path(@attendance, {tab: 'exams'})
  end

  it "go to samples" do
    visit workflow_path(@attendance, {tab: 'exams'})
    click_link id: 'samples-nav'
    expect(page).to have_current_path workflow_path(@attendance, {tab: 'samples'})
  end

  it "go to workmaps" do
    visit workflow_path(@attendance, {tab: 'exams'})
    click_link id: 'work-maps-nav'
    expect(page).to have_current_path workflow_path(@attendance, {tab: 'work_maps'})
  end

  it "go to reports" do
    visit workflow_path(@attendance, {tab: 'exams'})
    click_link id: 'reports-nav'
    expect(page).to have_current_path workflow_path(@attendance, {tab: 'reports'})
  end

  it "go to patient" do
    visit workflow_path(@attendance, {tab: 'patient'})
    click_link id: 'patient-nav'
    expect(page).to have_current_path workflow_path(@attendance, {tab: 'patient'})
  end

  it "visit patient profile" do
    visit workflow_path(@attendance, {tab: 'exams'})
    click_link id: 'patient-link'
    expect(page).to have_current_path patient_path(@attendance.patient)
  end

end
