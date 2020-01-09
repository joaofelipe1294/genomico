require 'rails_helper'

RSpec.feature "User::Workflow::Exams::ChangeStatus::TecnicalReleaseds", type: :feature do
  include AttendanceHelper
  include UserLogin

  it "change in progress exam to tecnical released" do
    Rails.application.load_seed
    attendance = create_in_progress_biomol_attendance
    biomol_user_do_login
    visit workflow_path(attendance, tab: 'exams')
    click_link class: "change-to-tecnical-released", match: :first
    expect(page).to have_current_path workflow_path(attendance, tab: 'exams')
    expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Liberado técnico."
    expect(attendance.exams.first.reload.exam_status_kind).to eq ExamStatusKind.TECNICAL_RELEASED
  end

end
