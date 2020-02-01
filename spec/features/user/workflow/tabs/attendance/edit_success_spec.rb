require 'rails_helper'

RSpec.feature "User::Workflow::Tabs::Attendance::Edits", type: :feature do
  include AttendanceHelper
  include UserLogin

  before :each do
    Rails.application.load_seed
    @attendance = create_raw_biomol_attendance
    biomol_user_do_login
    visit workflow_path(@attendance, tab: 'attendance')
  end

  after :each do
    expect(page).to have_current_path workflow_path(@attendance, {tab: "attendance"})
    expect(find(id: "success-warning").text).to eq I18n.t :attendance_update_success
  end

  it "change desease_stage" do
    distinct_desease_stage = "DRM"
    select(distinct_desease_stage, from: "attendance[desease_stage]").select_option
    click_button id: "btn-save"
    expect(@attendance.reload.desease_stage).to eq :drm.to_s
  end

  it "change cid_code" do
    new_cid_code = "871263kjsbd"
    fill_in "attendance[cid_code]", with: new_cid_code
    click_button id: "btn-save"
    expect(@attendance.reload.cid_code).to eq new_cid_code
  end

  it "change lis_code" do
    new_lis_code = "871623kjasdgb"
    fill_in "attendance[lis_code]", with: new_lis_code
    click_button id: "btn-save"
    expect(@attendance.reload.lis_code).to eq new_lis_code
  end

  it "change health_ensurance" do
    new_health_ensurance = HealthEnsurance.where.not(id: @attendance.health_ensurance.id).sample
    select(new_health_ensurance.name, from: "attendance[health_ensurance_id]").select_option
    click_button id: "btn-save"
    expect(@attendance.reload.health_ensurance).to eq new_health_ensurance
  end

  it "change doctor name" do
    new_doctor_name = "Strange"
    fill_in "attendance[doctor_name]", with: new_doctor_name
    click_button id: "btn-save"
    expect(@attendance.reload.doctor_name).to eq new_doctor_name
  end

  it "change doctor crm" do
    new_doctor_crm = "765123b"
    fill_in "attendance[doctor_crm]", with: new_doctor_crm
    click_button id: "btn-save"
    expect(@attendance.reload.doctor_crm).to eq new_doctor_crm
  end

  it "change observations" do
    new_observations = "Some things are strange here !"
    fill_in "attendance[observations]", with: new_observations
    click_button id: "btn-save"
    expect(@attendance.reload.observations).to eq new_observations
  end

end
