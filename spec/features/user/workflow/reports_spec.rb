require 'rails_helper'
require 'helpers/attendance'
require 'helpers/user'

RSpec.feature "User::Workflow::Reports", type: :feature, js: true do

  before :each do
    Rails.application.load_seed
    Object.send(:remove_const, :ExamStatusKinds) if Module.const_defined?(:ExamStatusKinds)
    Object.send(:remove_const, :AttendanceStatusKinds) if Module.const_defined?(:AttendanceStatusKinds)
    load 'app/models/concerns/exam_status_kinds.rb'
    load 'app/models/concerns/attendance_status_kinds.rb'
  end

  it "list exams with reports" do
    create_attendance
    imunofeno_user_do_login
    click_link class: 'attendance-code', match: :first
    click_button id: 'exam_nav'
    @first_exam =  @attendance.exams
                                    .joins(:offered_exam)
                                    .where("offered_exams.field_id = ?", Field.IMUNOFENO.id)
                                    .order("offered_exams.name ASC").first
    click_button id: 'sample_nav'
    click_link class: 'new-internal-code', match: :first
    click_button id: 'exam_nav'
    click_link class: 'start-exam', match: :first
    click_button id: 'btn-save'
    click_button id: 'exam_nav'
    visit current_path
    click_button 'exam_nav'
    click_link class: 'change-to-complete', match: :first
    page.driver.browser.switch_to.alert.accept
    visit current_path
    click_button id: 'exam_nav'
    click_link class: 'add-report', match: :first
    attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
    click_button id: 'btn-save'
    click_button id: 'report_nav'
    expect(find_all(class: 'report').size).to eq Exam.where(exam_status_kind: ExamStatusKind.COMPLETE).size
  end

  it "remove report from partial released exam" do
    create_attendance
    exam = Exam.joins(:offered_exam).where("offered_exams.field_id = ?", Field.IMUNOFENO).sample
    Exam.where.not(id: exam.id).delete_all
    exam.exam_status_kind = ExamStatusKind.COMPLETE_WITHOUT_REPORT
    exam.partial_released_report = File.open "#{Rails.root}/spec/support_files/PDF.pdf"
    exam.save
    imunofeno_user_do_login
    visit workflow_path(exam.attendance)
    click_button id: 'report_nav'
    click_link class: 'remove-report', match: :first
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_current_path workflow_path(exam.attendance), ignore_query: true
    expect(find(id: "success-warning").text).to eq I18n.t :remove_report_success
    click_button id: "report_nav"
    expect(find_all(class: 'report').size).to eq 0
  end

end
