require 'rails_helper'

RSpec.feature "User::Workflow::Exams::Start::Biomols", type: :feature do
  include UserLogin
  include AttendanceHelper

  before :each do
    Rails.application.load_seed
    @attendance = create_raw_biomol_attendance
    biomol_user_do_login
    visit attendance_path(@attendance, tab: 'exams')
  end

  context "when attendance has_internal codes" do

    after :each do
      expect(page).to have_current_path attendance_path(@attendance, tab: 'exams')
      expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Em andamento."
    end

    it "start exam success with single subsample" do
      click_link class: "start-exam", match: :first
      internal_code_to_be_selected = @attendance.subsamples.sample.internal_codes.sample
      select(internal_code_to_be_selected.code, from: "exam[internal_codes]").select_option
      click_button id: "btn-save"
      internal_code_saved = @attendance.exams.first.reload.internal_codes.first
      expect(internal_code_to_be_selected).to eq internal_code_saved
    end

    it "start_exam with compose subsample" do
      click_link class: "start-exam", match: :first
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
      select(compose_code.to_s, from: "exam[internal_codes]").select_option
      click_button id: "btn-save"
      expect(@attendance.exams.first.reload.internal_codes.size).to eq 2
    end

  end

  it "without internal codes" do
    @attendance.internal_codes.delete_all
    click_link class: "start-exam", match: :first
    expect(find(id: "without-sample")).to be_visible
  end


end
