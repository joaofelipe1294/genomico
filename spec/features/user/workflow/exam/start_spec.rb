# require 'rails_helper'
#
# RSpec.feature "User::Workflow::Exam::Starts", type: :feature, js: true do
#   include UserLogin
#   include AttendanceHelper
#
#   before(:each) { Rails.application.load_seed }
#
#   context "BIOMOL start exam validations" do
#
#     before :each do
#       @attendance = create_raw_biomol_attendance
#       biomol_user_do_login
#       visit workflow_path(@attendance.id, {tab: 'exams'})
#     end
#
#     it "with single subsample" do
#       create(:subsample, sample: @attendance.samples.first)
#       visit workflow_path(@attendance.id, {tab: 'exams'})
#       click_button id: 'exam_nav'
#       click_link class: 'start-exam', match: :first
#       click_button id: 'btn-save'
#       expect(page).to have_current_path workflow_path(@attendance, tab: 'exams')
#       expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Em andamento."
#     end
#
#     it "with two subsamples RNA and DNA", js: true do
#       visit workflow_path(@attendance.id, {tab: 'exams'})
#       visit start_exam_path(@attendance.exams.first)
#       select("", from: "exam[internal_codes]", match: :first).select_option
#       click_button id: 'btn-save'
#       expect(page).to have_current_path workflow_path(@attendance, tab: 'exams')
#       expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Em andamento."
#     end
#
#     it "with distinct subsample kinds" do
#
#       visit workflow_path(@attendance.id, {tab: 'exams'})
#       visit start_exam_path(@attendance.exams.first)
#       options = find_all(class: "internal-code-option").size
#       expect(options).to eq 4
#     end
#
#   end
#
# end
