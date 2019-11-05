require 'rails_helper'

RSpec.feature "User::Workflow::Sample::NewSubsamples", type: :feature, js: true do
  include UserLogin
  include ExamSupport
  include SubsampleSupport

  def success_confirmation
    fill_subsample_values @subsample
    click_button id: "btn-save"
    expect(page).to have_current_path workflow_path(@attendance, {tab: "samples"})
    expect(find(id: "success-warning").text).to eq I18n.t :new_subsample_success
  end

  def setup
    Rails.application.load_seed
    @attendance = create(:attendance, exams: [biomol_exam])
    biomol_user_do_login
    visit new_sub_sample_path(@attendance.samples.sample)
    @subsample = generate_subsample(sample: @attendance.samples.sample)
  end

  context "subsample atributes" do

    before(:each){ setup }

    after(:each){ success_confirmation }

    it "complete RNA", js: true do
    end

    it "without storage location" do
      @subsample.storage_location = ""
      fill_subsample_values @subsample
    end

  end

  context "without nanodrop data" do

    before(:each){ setup }

    after(:each){ success_confirmation }

    it "concentration" do
      @subsample.nanodrop_report.concentration = ""
    end

    it "rate_260_280" do
      @subsample.nanodrop_report.rate_260_280 = ""
    end

    it "rate_260_230" do
      @subsample.nanodrop_report.rate_260_230 = ""
    end

    it "without any" do
      @subsample.nanodrop_report.concentration = ""
      @subsample.nanodrop_report.rate_260_230 = ""
      @subsample.nanodrop_report.rate_260_280 = ""
    end

  end

  context "without qubit" do

    it "wihtou qubut concentration" do
      setup
      @subsample.qubit_report.concentration = ""
      success_confirmation
    end

  end

  context "hemacounter_report" do

    context "with RNA subsample kind" do

      before(:each){ setup }

      after(:each){ success_confirmation}

      it "without leukocyte_total_count" do
        @subsample.hemacounter_report.leukocyte_total_count = ""
      end

      it "without volume" do
        @subsample.hemacounter_report.volume = ""
      end

      it "without pellet_leukocyte_count" do
        @subsample.hemacounter_report.pellet_leukocyte_count = ""
      end

    end

    context "with DNA subsample kind" do

      before :each do
        Rails.application.load_seed
        @attendance = create(:attendance, exams: [biomol_exam])
        biomol_user_do_login
        visit new_sub_sample_path(@attendance.samples.sample)
        @subsample = generate_subsample(sample: @attendance.samples.sample, subsample_kind: SubsampleKind.DNA)
      end

      after(:each){ success_confirmation }

      it "without leukocyte_total_count" do
        @subsample.hemacounter_report.leukocyte_total_count = ""
      end

      it "without volume" do
        @subsample.hemacounter_report.volume = ""
      end

      it "without pellet_leukocyte_count" do
        @subsample.hemacounter_report.pellet_leukocyte_count = ""
      end

    end

    context "check hemacounter_report render" do

      before :each do
        Rails.application.load_seed
        @attendance = create(:attendance, exams: [biomol_exam])
        biomol_user_do_login
        visit new_sub_sample_path(@attendance.samples.sample)
      end

      it "change to VIRAL_DNA" do
        select(SubsampleKind.VIRAL_DNA.name, from: "subsample[subsample_kind_id]").select_option
        expect(page).not_to have_selector('#hemacounter-form', visible: true)
      end

      it "change to VIRAL_DNA then RNA again" do
        select(SubsampleKind.VIRAL_DNA.name, from: "subsample[subsample_kind_id]").select_option
        expect(page).not_to have_selector('#hemacounter-form', visible: true)
        select(SubsampleKind.RNA.name, from: "subsample[subsample_kind_id]").select_option
        expect(page).to have_selector('#hemacounter-form', visible: true)
      end

    end

  end

end
