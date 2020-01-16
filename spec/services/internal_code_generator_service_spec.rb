require 'rails_helper'

describe 'InternalCodeGeneratorService' do

  before :each do
    Rails.application.load_seed
    patient = create(:patient)
  end

  describe "when creating a new sample" do

    context "when field is imunofeno" do

      before :each do
        @attendance = create(:imunofeno_attendance)
        sample = @attendance.samples.first
        @internal_code = create(:internal_code, sample: sample, field: Field.IMUNOFENO)
      end

      it "is expected to follow its own order" do
        expect(@internal_code.reload.code).to match "200001"
      end

      it "is expected to increase independent of sample kind" do
        sample = create(:imunofeno_sample, attendance: @attendance, sample_kind: SampleKind.LIQUOR)
        second_internal_code = create(:internal_code, field: Field.IMUNOFENO, sample: sample)
        expect(second_internal_code.code).to match "200002"
      end

    end

  end

  describe "when creating a subsample" do

    context "when attendance belongs to Biomol" do

      it "is expected to increase index only same kind subsamples" do
        attendance = create(:biomol_attendance)
        sample = attendance.samples.first
        subsample = create(:subsample, sample: sample, subsample_kind: SubsampleKind.DNA)
        internal_code = subsample.internal_codes.first
        expect(internal_code.reload.code).to match "#{Date.today.year.to_s.slice(2, 3)}-#{SubsampleKind.DNA.acronym}-0419"
        subsample = create(:subsample, sample: sample, subsample_kind: SubsampleKind.RNA)
        new_internal_code = subsample.internal_codes.first
        expect(new_internal_code.code).to match "#{Date.today.year.to_s.slice(2, 3)}-#{SubsampleKind.RNA.acronym}-0311"
      end

    end

  end

end
