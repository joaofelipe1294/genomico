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
end

RSpec.describe QubitReport, type: :model do

	context 'Validations' do

		it 'correct' do
			qubit_report = create(:qubit_report, subsample: @attendance.samples.first)
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
