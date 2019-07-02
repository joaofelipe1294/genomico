require 'rails_helper'

RSpec.describe NanodropReport, type: :model do

	context 'Validations' do

		it 'correct' do
			nanodrop_report = create(:nanodrop_report)
			expect(nanodrop_report).to be_valid
		end

		it 'without subsample' do
			nanodrop_report = build(:nanodrop_report, subsample: nil)
			nanodrop_report.save
			expect(nanodrop_report).to be_invalid
		end

		it 'without concentration' do
			nanodrop_report = build(:nanodrop_report, concentration: nil)
			nanodrop_report.save
			expect(nanodrop_report).to be_valid
		end

		it 'without rate_260_280' do
			nanodrop_report = build(:nanodrop_report, rate_260_280: nil)
			nanodrop_report.save
			expect(nanodrop_report).to be_valid
		end

		it 'without rate_260_230' do
			nanodrop_report = build(:nanodrop_report, rate_260_230: nil)
			nanodrop_report.save
			expect(nanodrop_report).to be_valid
		end

	end

	context 'Relations' do

		it { should belong_to(:subsample) }

	end

end
