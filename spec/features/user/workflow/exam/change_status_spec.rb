require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Workflow::Exam::ChangeStatuses", type: :feature, js: true do

    context "change exam status IMUNOFENO" do

      before :each do
        Rails.application.load_seed
        exam = build(:exam, offered_exam: OfferedExam.where(field: Field.IMUNOFENO).where(is_active: true).sample)
        sample = build(:sample, sample_kind: SampleKind.LIQUOR)
        @attendance = create(:attendance, exams: [exam], samples: [sample])
        internal_code = create(:internal_code, sample: sample, field: Field.IMUNOFENO)
        @attendance.exams.first.exam_status_kind = ExamStatusKind.IN_PROGRESS
        @attendance.exams.first.internal_codes << internal_code
        @attendance.save
        imunofeno_user_do_login
        visit workflow_path(@attendance.id, {tab: 'exams'})
      end

      it "tecnical released" do
        click_link class: 'change-to-tecnical-released', match: :first
        expect(page).to have_current_path workflow_path(@attendance, {tab: 'exams'})
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.TECNICAL_RELEASED.name}."
      end

      it "in repeat" do
        click_link class: 'change-to-in-repeat', match: :first
        expect(page).to have_current_path workflow_path(@attendance, {tab: 'exams'})
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.IN_REPEAT.name}."
      end

      it "partial released" do
        click_link class: 'change-to-partial-released', match: :first
        expect(page).to have_current_path change_to_partial_released_path(@attendance.exams.first)
        attach_file "exam[partial_released_report]", "#{Rails.root}/spec/support_files/PDF.pdf"
        click_button id: "btn-save"
        expect(page).to have_current_path workflow_path(@attendance, {tab: "exams"})
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Liberado parcial."
      end

      it "complete exam without report" do
        visit current_path
        click_button 'exam_nav'
        click_link class: 'change-to-complete', match: :first
        page.driver.browser.switch_to.alert.accept
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.COMPLETE_WITHOUT_REPORT.name}."
        expect(page).to have_current_path add_report_to_exam_path(@attendance.exams.first)
      end

      it "complete exam with report" do
        visit current_path
        click_button 'exam_nav'
        click_link class: 'change-to-complete', match: :first
        page.driver.browser.switch_to.alert.accept
        attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
        click_button id: "btn-save"
        expect(page).to have_current_path workflow_path(@attendance, {tab: "exams"})
        expect(find(id: 'success-warning').text).to eq "Atendimento encerrado com sucesso."
      end

    end

    context "change exam status BIOMOL" do

      before :each do
        Rails.application.load_seed
        exam = build(:exam, offered_exam: OfferedExam.where(field: Field.BIOMOL).where(is_active: true).sample)
        sample = build(:sample, sample_kind: SampleKind.PERIPHERAL_BLOOD)
        @attendance = create(:attendance, exams: [exam], samples: [sample])
        create(:subsample, sample: @attendance.samples.first, subsample_kind: SubsampleKind.DNA)
        create(:subsample, sample: @attendance.samples.first, subsample_kind: SubsampleKind.RNA)
        create(:subsample, sample: @attendance.samples.first, subsample_kind: SubsampleKind.VIRAL_DNA)
        @attendance.exams.first.exam_status_kind = ExamStatusKind.IN_PROGRESS
        @attendance.exams.first.internal_codes << @attendance.internal_codes.sample
        @attendance.save
        biomol_user_do_login
        visit workflow_path(@attendance.id, {tab: 'exams'})
      end

      it "tecnical released" do
        click_link class: 'change-to-tecnical-released', match: :first
        expect(page).to have_current_path workflow_path(@attendance, {tab: 'exams'})
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.TECNICAL_RELEASED.name}."
      end

      it "in repeat" do
        click_link class: 'change-to-in-repeat', match: :first
        expect(page).to have_current_path workflow_path(@attendance, {tab: 'exams'})
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.IN_REPEAT.name}."
      end

      it "partial released" do
        click_link class: 'change-to-partial-released', match: :first
        expect(page).to have_current_path change_to_partial_released_path(@attendance.exams.first)
        attach_file "exam[partial_released_report]", "#{Rails.root}/spec/support_files/PDF.pdf"
        click_button id: "btn-save"
        expect(page).to have_current_path workflow_path(@attendance, {tab: "exams"})
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Liberado parcial."
      end

      it "complete exam without report" do
        visit current_path
        click_button 'exam_nav'
        click_link class: 'change-to-complete', match: :first
        page.driver.browser.switch_to.alert.accept
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para #{ExamStatusKind.COMPLETE_WITHOUT_REPORT.name}."
        expect(page).to have_current_path add_report_to_exam_path(@attendance.exams.first)
      end

      it "complete exam with report" do
        visit current_path
        click_button 'exam_nav'
        click_link class: 'change-to-complete', match: :first
        page.driver.browser.switch_to.alert.accept
        attach_file "exam[report]", "#{Rails.root}/spec/support_files/PDF.pdf"
        click_button id: "btn-save"
        expect(page).to have_current_path workflow_path(@attendance, {tab: "exams"})
        expect(find(id: 'success-warning').text).to eq "Atendimento encerrado com sucesso."
      end

    end

end
