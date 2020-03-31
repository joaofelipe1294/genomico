require 'rails_helper'

RSpec.feature "User::Workflow::Exams::Edit::EditExams", type: :feature, js: true do
  include AttendanceHelper
  include UserLogin

  before(:each) { Rails.application.load_seed }

  after :each do
    expect(page).to have_current_path attendance_path(@attendance, tab: 'exams')
    exam = @attendance.exams.first.reload
    expect(exam.offered_exam).to eq @new_offered_exam
  end

  it "change exam kind waiting to start" do
    @attendance = create_raw_biomol_attendance
    biomol_user_do_login
    visit attendance_path(@attendance, tab: 'exams')
    click_link class: "edit-exam", match: :first
    expect(page).to have_current_path edit_exam_path(@attendance.exams.first)
    old_offered_exam = @attendance.exams.first.offered_exam
    @new_offered_exam = OfferedExam.where(field: Field.BIOMOL).where(is_active: true).sample
    select(@new_offered_exam.name, from: "exam[offered_exam_id]").select_option
    click_button id: "btn-save"
  end

  it "change exam kind in progress exam" do
    @attendance = create_in_progress_imunofeno_attendance
    imunofeno_user_do_login
    visit attendance_path(@attendance, tab: 'exams')
    click_link class: 'edit-exam', match: :first
    current_internal_code = @attendance.exams.first.internal_codes.first
    old_offered_exam = @attendance.exams.first.offered_exam
    @new_offered_exam = OfferedExam.where(field: Field.IMUNOFENO).where(is_active: true).sample
    select(@new_offered_exam.name, from: "exam[offered_exam_id]").select_option
    click_button id: "btn-save"
    edited_exam = @attendance.exams.first.reload
    expect(current_internal_code).to eq edited_exam.internal_codes.first
  end

end
