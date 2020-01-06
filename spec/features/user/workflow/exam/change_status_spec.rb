require 'rails_helper'

RSpec.feature "User::Workflow::Exam::ChangeStatuses", type: :feature, js: true do
  include UserLogin
  include AttendanceHelper
  include ValidationChecks

    def change_exam_status_to_complete
      visit current_path
      click_button 'exam_nav'
      page.driver.browser.accept_confirm
      click_link class: 'change-to-complete', match: :first
    end

  context "change exam status IMUNOFENO" do

    before :each do
      Rails.application.load_seed
      @attendance = create_imunofeno_attendance
      @expected_result_path = workflow_path(@attendance, {tab: 'exams'})
      imunofeno_user_do_login
      visit workflow_path(@attendance.id, {tab: 'exams'})
    end

    context "change status and got o exams tab" do

      after :each do
        location_and_success_message_check message: @expected_message, path: @expected_result_path
      end

      it "tecnical released" do
        click_link class: 'change-to-tecnical-released', match: :first
        @expected_message = message = "Status de exame alterado para #{ExamStatusKind.TECNICAL_RELEASED.name}."
      end

      it "in repeat" do
        click_link class: 'change-to-in-repeat', match: :first
        @expected_message = "Status de exame alterado para #{ExamStatusKind.IN_REPEAT.name}."
      end

      it "partial released" do
        click_link class: 'change-to-partial-released', match: :first
        expect(page).to have_current_path change_to_partial_released_path(@attendance.exams.first)
        attach_file "exam[partial_released_report]", "#{Rails.root}/spec/support_files/PDF.pdf"
        click_button id: "btn-save"
        @expected_message = "Status de exame alterado para Liberado parcial."
      end

      it "complete exam with report" do
        change_exam_status_to_complete
        attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
        click_button id: "btn-save"
        @expected_message = "Atendimento encerrado com sucesso."
      end

    end

    it "complete exam without report" do
      change_exam_status_to_complete
      expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.COMPLETE_WITHOUT_REPORT.name}."
      expect(page).to have_current_path add_report_to_exam_path(@attendance.exams.first)
    end

  end

  context "change exam status BIOMOL" do

    before :each do
      Rails.application.load_seed
      @attendance = create_biomol_attendance
      @expected_result_path = workflow_path(@attendance.id, {tab: 'exams'})
      biomol_user_do_login
      visit workflow_path(@attendance.id, {tab: 'exams'})
    end

    context "change exam status and return to exams tab" do

      after :each do
        location_and_success_message_check message: @expected_message, path: @expected_result_path
      end

      it "tecnical released" do
        click_link class: 'change-to-tecnical-released', match: :first
        @expected_message = "Status de exame alterado para #{ExamStatusKind.TECNICAL_RELEASED.name}."
      end

      it "in repeat" do
        click_link class: 'change-to-in-repeat', match: :first
        @expected_message = "Status de exame alterado para #{ExamStatusKind.IN_REPEAT.name}."
      end

      it "partial released" do
        click_link class: 'change-to-partial-released', match: :first
        expect(page).to have_current_path change_to_partial_released_path(@attendance.exams.first)
        attach_file "exam[partial_released_report]", "#{Rails.root}/spec/support_files/PDF.pdf"
        click_button id: "btn-save"
        @expected_message = "Status de exame alterado para Liberado parcial."
      end

      it "complete exam with report" do
        change_exam_status_to_complete
        attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
        click_button id: "btn-save"
        @expected_message = "Atendimento encerrado com sucesso."
      end

    end

    it "complete exam without report" do
      change_exam_status_to_complete
      expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.COMPLETE_WITHOUT_REPORT.name}."
      expect(page).to have_current_path add_report_to_exam_path(@attendance.exams.first)
    end

  end

end
