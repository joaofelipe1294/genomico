require 'rails_helper'

RSpec.describe Patient, type: :model do

	context 'Validations' do

		it 'correct' do
			patient = create(:patient)
			expect(patient).to be_valid
		end

		it 'without name' do
			patient = build(:patient, name: nil)
			patient.save
			expect(patient).to be_invalid
		end

		it 'without medical_record' do
			patient = build(:patient, medical_record: nil)
			patient.save
			expect(patient).to be_invalid
		end

		it 'duplicated medical_record' do
			patient = create(:patient)
			duplicated = build(:patient, 
				medical_record: patient.medical_record,
				hospital: patient.hospital
			)
			duplicated.save
			expect(duplicated).to be_invalid
		end

		it 'without mother_name' do
			patient = build(:patient, mother_name: nil)
			patient.save
			expect(patient).to be_invalid
		end

		it 'without hospital' do
			patient = build(:patient, hospital: nil)
			patient.save
			expect(patient).to be_invalid
		end

		it 'with same name, birth_date, mother_name and hospital' do
			patient = create(:patient)
			duplicated = build(:patient, 
				name: patient.name, 
				mother_name: patient.mother_name, 
				birth_date: patient.birth_date,
				hospital: patient.hospital
			)
			duplicated.save
			expect(duplicated).to be_invalid
		end

	end

	context 'Relations' do

		it { should have_many(:attendances) }

		it { should belong_to(:hospital) }

	end

end
