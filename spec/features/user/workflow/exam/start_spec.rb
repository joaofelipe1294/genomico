require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Workflow::Exam::Starts", type: :feature, js: true do

  def without_internal_code_validation
    expect(page).to have_current_path start_exam_path(@attendance.exams.first)
    expect(find(id: 'exam-name').value).to eq @attendance.exams.first.offered_exam.name
    expect(page).to have_selector '#without-sample', visible: true
  end

  before :each do
    Rails.application.load_seed
  end

  context "IMUNOFENO exam validations" do

    before :each do
      exam = build(:exam, offered_exam: OfferedExam.where(field: Field.IMUNOFENO).where(is_active: true).sample)
      sample = build(:sample, sample_kind: SampleKind.LIQUOR)
      @attendance = create(:attendance, exams: [exam], samples: [sample])
      imunofeno_user_do_login
      visit workflow_path(@attendance.id, {tab: 'exams'})
    end

    context "exam verification" do

      it "try start exam without internal code" do
        click_link 'start-exam', match: :first
      end

      it "start exam" do
        internal_code = create(:internal_code, sample: @attendance.samples.first, field: Field.IMUNOFENO)
        visit current_path
        click_button id: 'exam_nav'
        click_link class: 'start-exam', match: :first
        click_button id: 'btn-save'
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Em andamento."
      end

    end

  end

  context "BIOMOL start exam validations" do

    before :each do
      exam = build(:exam, offered_exam: OfferedExam.where(field: Field.BIOMOL).where(is_active: true).sample)
      sample = build(:sample, sample_kind: SampleKind.PERIPHERAL_BLOOD)
      @attendance = create(:attendance, exams: [exam], samples: [sample])
      biomol_user_do_login
      visit workflow_path(@attendance.id, {tab: 'exams'})
    end

    it "without subsample code" do
      click_link class: 'start-exam', match: :first
      without_internal_code_validation
    end

    it "with single subsample" do
      create(:subsample, sample: @attendance.samples.first)
      visit workflow_path(@attendance.id, {tab: 'exams'})
      click_button id: 'exam_nav'
      click_link class: 'start-exam', match: :first
      click_button id: 'btn-save'
      expect(page).to have_current_path workflow_path(@attendance, tab: 'exams')
      expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Em andamento."
    end

    it "with two subsamples RNA and DNA" do
      create(:subsample, sample: @attendance.samples.first, subsample_kind: SubsampleKind.RNA)
      create(:subsample, sample: @attendance.samples.first, subsample_kind: SubsampleKind.DNA)
      visit workflow_path(@attendance.id, {tab: 'exams'})
      click_button id: 'exam_nav'
      click_link class: 'start-exam', match: :first
      compose_option = find_all("option").last.text
      select(compose_option, from: "exam[internal_code]").select_option
      click_button id: 'btn-save'
      expect(page).to have_current_path workflow_path(@attendance, tab: 'exams')
      expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Em andamento."
    end

    it "with distinct subsample kinds" do
      create(:subsample, sample: @attendance.samples.first, subsample_kind: SubsampleKind.RNA)
      create(:subsample, sample: @attendance.samples.first, subsample_kind: SubsampleKind.VIRAL_DNA)
      visit workflow_path(@attendance.id, {tab: 'exams'})
      click_button id: 'exam_nav'
      click_link class: 'start-exam', match: :first
      options = find_all("option").size
      expect(options).to eq 2
    end

  end

end
