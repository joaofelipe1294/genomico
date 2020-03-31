require 'rails_helper'

RSpec.feature "User::Workflow::Exams::Edit::Samples", type: :feature do
  include AttendanceHelper
  include UserLogin

  before(:each) { Rails.application.load_seed }

  it "try chage sample of waiting to start exam", js: true do
    attendance = create_raw_biomol_attendance
    biomol_user_do_login
    visit attendance_path(attendance, tab: 'exams')
    click_link class: "edit-exam", match: :first
    expect(page).not_to have_selector("#exam_internal_code_ids")
  end

  context "when exam is in progress", js: true do

    before :each do
      @attendance = create_in_progress_biomol_attendance
      biomol_user_do_login
      visit attendance_path(@attendance, tab: 'exams')
      click_link class: "edit-exam", match: :first
    end

    it "change internal code from in progress biomol exam, that uses single subsample" do
      current_internal_code = @attendance.exams.first.internal_codes.first
      new_internal_code = @attendance.internal_codes.where.not(id: current_internal_code.id).first
      select(new_internal_code.code, from: "exam[internal_code_ids]").select_option
      click_button id: "btn-save"
      expect(page).to have_current_path attendance_path(@attendance, tab: 'exams')
      exam = @attendance.exams.first.reload
      expect(exam.internal_codes.first).to eq new_internal_code
    end

    it "change internal code from in progress exam with compose sample" do
      dna_internal_code = @attendance
                                    .internal_codes
                                    .joins(:subsample)
                                    .where("subsamples.subsample_kind_id = ?", SubsampleKind.DNA.id)
                                    .first
      rna_internal_code = @attendance
                                    .internal_codes
                                    .joins(:subsample)
                                    .where("subsamples.subsample_kind_id = ?", SubsampleKind.RNA.id)
                                    .first
      compose_code = "#{dna_internal_code.code} - #{rna_internal_code.code}"
      select(compose_code.to_s, from: "exam[internal_code_ids]").select_option
      click_button id: "btn-save"
      expect(page).to have_current_path attendance_path(@attendance, tab: 'exams')
      exam = @attendance.exams.first.reload
      expect(exam.internal_codes.size).to eq 2
    end

  end

end
