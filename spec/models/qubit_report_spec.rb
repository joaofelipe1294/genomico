require 'rails_helper'

RSpec.describe QubitReport, type: :model do

	context 'Validations' do

		it 'correct' do
			qubit_report = create(:qubit_report)
			expect(qubit_report).to be_valid
		end

		it 'without subsample' do
			qubit_report = build(:qubit_report, subsample: nil)
			qubit_report.save
			expect(qubit_report).to be_valid
		end

		it 'without' do
			qubit_report = build(:qubit_report, concentration: nil)
			qubit_report.save
			expect(qubit_report).to be_valid
		end

	end

	context 'Relations' do

		it { should belong_to(:subsample) }

	end

end
