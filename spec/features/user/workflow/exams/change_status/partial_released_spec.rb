require 'rails_helper'

RSpec.feature "User::Workflow::Exams::ChangeStatus::PartialReleaseds", type: :feature do
  include AttendanceHelper
  include UserLogin

  before :each do
    Rails.application.load_seed
    @attendance = create_in_progress_imunofeno_attendance
    imunofeno_user_do_login
    visit workflow_path(@attendance, tab: 'exams')
    click_link class: "change-to-partial-released", match: :first
    expect(page).to have_current_path change_to_partial_released_path(@attendance.exams.first)
  end

  it "change exam status to partial released" do
    attach_file "exam[partial_released_report]", "#{Rails.root}/spec/support_files/PDF.pdf"
    click_button id: "btn-save"
    expect(page).to have_current_path workflow_path(@attendance, tab: 'exams')
    expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Liberado parcial."
    exam = @attendance.exams.first.reload
    expect(exam.status).to eq :partial_released.to_s
  end

  it "replace partial released report" do
    attach_file "exam[partial_released_report]", "#{Rails.root}/spec/support_files/PDF.pdf"
    click_button id: "btn-save"
    exam = @attendance.exams.first.reload
    expect(exam.partial_released_report_file_name).to eq "PDF.pdf"
    click_link class: "change-to-partial-released", match: :first
    attach_file "exam[partial_released_report]", "#{Rails.root}/spec/support_files/PDF_2.pdf"
    click_button id: "btn-save"
    exam = @attendance.exams.first.reload
    expect(exam.partial_released_report_file_name).to eq "PDF_2.pdf"
  end

  it "try send form without pdf attached", js: true do
    click_button id: "btn-save"
    expect(page).to have_current_path change_to_partial_released_path(@attendance.exams.first)
  end

end
