require 'rails_helper'

RSpec.feature "User::Workflow::Tabs::Attendance::Shows", type: :feature do
  include AttendanceHelper
  include UserLogin

  it "check attendance tab data" do
    Rails.application.load_seed
    attendance = create_raw_imunofeno_attendance
    imunofeno_user_do_login
    visit workflow_path(attendance, {tab: 'attendance'})
    expect(attendance.patient.name). to eq find(id: "attendance_patient").value
    expect(I18n.l(attendance.start_date.to_date)).to eq find(id: "attendance_start_date").value
    expect(attendance.attendance_status_kind.name).to eq find(id: "attendance_attendance_status_kind").value
    expect(attendance.desease_stage.id.to_s).to eq find(id: 'attendance_desease_stage_id').value
    expect(attendance.cid_code).to eq find(id: "attendance_cid_code").value
    expect(attendance.lis_code).to eq find(id: "attendance_lis_code").value
    expect(attendance.health_ensurance_id.to_s).to eq find(id: "attendance_health_ensurance_id").value
    expect(attendance.doctor_name).to eq find(id: "attendance_doctor_name").value
    expect(attendance.doctor_crm).to eq find(id: "attendance_doctor_crm").value
    expect(attendance.observations).to eq find(id: "attendance_observations").value
  end

end
