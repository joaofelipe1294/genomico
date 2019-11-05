require 'rails_helper'

RSpec.describe HemacounterReport, type: :model do

  context "hemacounter_report specs" do

    before :each do
      Rails.application.load_seed
      attendance = create(:attendance)
      create(:subsample, sample: attendance.samples.sample, subsample_kind: SubsampleKind.RNA)
    end

    it "complete" do
      hemacounter_report = build(:hemacounter_report)
      expect(hemacounter_report).to be_valid
    end

    context "without required values" do

      context "invalid options" do

        after :each do
          expect(@hemacounter_report).to be_invalid
        end

        it "subsample" do
          @hemacounter_report = build(:hemacounter_report, subsample: nil)
        end

      end

      it "pellet_leukocyte_count" do
        hemacounter_report = build(:hemacounter_report, pellet_leukocyte_count: nil)
        expect(hemacounter_report).to be_valid
      end

      it "leukocyte_total_count" do
        hemacounter_report = build(:hemacounter_report, leukocyte_total_count: nil)
        expect(hemacounter_report).to be_valid
      end

      it "volume" do
        hemacounter_report = build(:hemacounter_report, volume: nil)
        expect(hemacounter_report).to be_valid
      end

      it "cellularity" do
        hemacounter_report = build(:hemacounter_report, cellularity: nil)
        expect(hemacounter_report).to be_valid
      end

    end

    context "cellularity calc" do

      it "correct" do
        hemacounter_report = build(:hemacounter_report, volume: 2.3, leukocyte_total_count: 3.1)
        expect(hemacounter_report).to be_valid
        expect(hemacounter_report.cellularity).to eq (2.3 * 3.1)
      end

      it "cellularity negative" do
        hemacounter_report = build(:hemacounter_report, volume: -1, leukocyte_total_count: 3.1)
        expect(hemacounter_report).to be_invalid
      end

    end

  end

end
