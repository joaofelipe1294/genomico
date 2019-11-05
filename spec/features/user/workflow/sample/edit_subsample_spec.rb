require 'rails_helper'

RSpec.feature "User::Workflow::Sample::EditSubsamples", type: :feature, js: true do
  include UserLogin
  include ExamSupport
  include SubsampleSupport

  def check_success
    fill_subsample_values @new_subsample_values
    click_button id: "btn-save"
    expect(find(id: "success-warning").text).to eq I18n.t :edit_subsample_success
    expect(page).to have_current_path workflow_path(@attendance, {tab: "samples"})
  end

  def setup
    Rails.application.load_seed
    exams = [biomol_exam]
    @attendance = create(:attendance, exams: exams)
    sample = @attendance.samples.sample
    subsample = generate_subsample sample: sample
    subsample.save
    biomol_user_do_login
    visit edit_subsample_path(subsample)
    @new_subsample_values = generate_subsample sample: sample
  end

  it "edit subsample ok" do
    setup
    check_success
  end

  context "nanodrop_report" do

    before(:each){ setup }

    after(:each){ check_success }

    it "without concentration" do
      @new_subsample_values.nanodrop_report.concentration = ""
    end

    it "rate_260_230" do
      @new_subsample_values.nanodrop_report.rate_260_230 = ""
    end

    it "rate_260_280" do
      @new_subsample_values.nanodrop_report.rate_260_280 = ""
    end

    it "all" do
      @new_subsample_values.nanodrop_report.concentration = ""
      @new_subsample_values.nanodrop_report.rate_260_230 = ""
      @new_subsample_values.nanodrop_report.rate_260_280 = ""
    end

  end

  context "qubit" do

    it "without concentration" do
      setup
      @new_subsample_values.qubit_report.concentration = ""
      check_success
    end

  end

  context "hemacounter_report" do

    before(:each) { setup }
    after :each do
      click_button id: "btn-save"
      expect(page).to have_current_path workflow_path(@attendance, {tab: "samples"})
      expect(find(id: "success-warning").text).to eq I18n.t :edit_subsample_success
    end

    it "without leukocyte_total_count" do
      fill_in "subsample[hemacounter_report_attributes][leukocyte_total_count]", with: ""
    end

    it "without volume" do
      fill_in "subsample[hemacounter_report_attributes][volume]", with: ""
    end

    it "without pellet_leukocyte_count" do
      fill_in "subsample[hemacounter_report_attributes][pellet_leukocyte_count]", with: ""
    end

  end

end
