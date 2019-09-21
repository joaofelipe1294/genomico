require 'rails_helper'

def setup
	Rails.application.load_seed
	patient = Patient.new(id: 8)
	patient.save!(validate: false)
	sample = Sample.new({
		sample_kind: SampleKind.all.sample,
		collection_date: Date.today,
		bottles_number: 1,
	})
	@attendance = Attendance.new({
		id: 1,
		patient: patient,
		samples: [ sample ]
	})
	@attendance.save!(validate: false)
	@subsample = Subsample.new({
		sample: @attendance.samples.sample,
		subsample_kind: SubsampleKind.all.sample,
		collection_date: Date.today
	})
end

RSpec.describe NanodropReport, type: :model do

	context 'Validations' do

		before :each do
			setup
		end

		it 'correct' do
			nanodrop_report = create(:nanodrop_report, subsample: @subsample)
			expect(nanodrop_report).to be_valid
		end

		it 'without subsample' do
			nanodrop_report = build(:nanodrop_report, subsample: nil)
			nanodrop_report.save
			expect(nanodrop_report).to be_valid
		end

		it 'without concentration' do
			nanodrop_report = build(:nanodrop_report, subsample: @subsample, concentration: nil)
			nanodrop_report.save
			expect(nanodrop_report).to be_valid
		end

		it 'without rate_260_280' do
			nanodrop_report = build(:nanodrop_report, subsample: @subsample, rate_260_280: nil)
			nanodrop_report.save
			expect(nanodrop_report).to be_valid
		end

		it 'without rate_260_230' do
			nanodrop_report = build(:nanodrop_report, subsample: @subsample, rate_260_230: nil)
			nanodrop_report.save
			expect(nanodrop_report).to be_valid
		end

	end

	context 'Relations' do

		it { should belong_to(:subsample) }

	end

end
