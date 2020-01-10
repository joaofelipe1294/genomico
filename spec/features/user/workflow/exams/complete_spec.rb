require 'rails_helper'

RSpec.feature "User::Workflow::Exams::Completes", type: :feature do
  include AttendanceHelper
  include UserLogin

  before :each do
    Rails.application.load_seed
    @attendance = create_in_progress_biomol_attendance
    biomol_user_do_login
    visit workflow_path(@attendance, tab: 'exams')
    page.driver.browser.accept_confirm
    click_link class: "change-to-complete", match: :first
    @exam = @attendance.exams.first.reload
    expect(@exam.exam_status_kind).to eq ExamStatusKind.COMPLETE_WITHOUT_REPORT
    expect(find(id: "success-warning").text).to eq "Status de exame alterado para Concluído (sem laudo)."
    expect(page).to have_current_path add_report_to_exam_path(@exam)
  end

  it "complete exam without report", js: true do
    expect(@attendance.reload.attendance_status_kind).to eq AttendanceStatusKind.IN_PROGRESS
  end

  it "complete exam with report", js: true do
    attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
    click_button id: "btn-save"
    expect(find(id: "success-warning").text).to eq "Atendimento encerrado com sucesso."
    expect(@attendance.reload.attendance_status_kind).to eq AttendanceStatusKind.COMPLETE
    expect(@exam.reload.exam_status_kind).to eq ExamStatusKind.COMPLETE
  end

end
