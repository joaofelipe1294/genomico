require 'rails_helper'

def complete_exam
  @first_exam = @attendance.exams
                            .joins(:offered_exam)
                            .where("offered_exams.field_id = ?", Field.IMUNOFENO.id)
                            .order("offered_exams.name ASC").first
  click_button id: 'sample_nav'
  current_attendance = current_path
  click_link class: 'new-internal-code', match: :first
  click_button id: 'exam_nav'
  click_link class: 'start-exam', match: :first
  click_button id: 'btn-save'
  click_button id: 'exam_nav'
  visit current_path
  click_button 'exam_nav'
  page.driver.browser.accept_confirm
  click_link class: 'change-to-complete', match: :first
  visit current_attendance
end

RSpec.feature "User::Workflow::FinishAttendances", type: :feature, js: true do
  include UserLogin
  include DataGenerator

  before :each do
    Rails.application.load_seed
    create_attendance
    @attendance.exams.includes(:offered_exam).each do |exam|
      exam.delete if exam.offered_exam.field != Field.IMUNOFENO
    end
    @attendance.exams = Exam.joins(:offered_exam).where("offered_exams.field_id = ?", Field.IMUNOFENO.id)
    @attendance.save
    imunofeno_user_do_login
    click_link class: 'attendance-code', match: :first
    click_button id: 'exam_nav'
    complete_exam
    click_button id: 'exam_nav'
    click_link class: 'add-report', match: :first
    attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
    click_button id: 'btn-save'
    complete_exam
  end

  it "finish attendance with exams and reports" do
    click_button id: 'exam_nav'
    click_link class: 'add-report', match: :first
    attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
    click_button id: 'btn-save'
    visit current_path
    @attendance = Attendance.find(@attendance.id)
    expect(@attendance.attendance_status_kind).to eq AttendanceStatusKind.COMPLETE
    expect(find(id: 'success-warning').text).to eq I18n.t :complete_attendance_success
    expect(find(class: 'alert-primary', match: :first).text).to eq "Atendimento encerrado em #{I18n.l @attendance.finish_date.to_date}."
  end

  it "attendance with complete exams but pending reports" do
    visit current_path
    expect(find(class: 'alert-primary').text).to eq I18n.t :pending_reports_message
  end

end
