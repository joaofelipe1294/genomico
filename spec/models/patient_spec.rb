require 'rails_helper'

RSpec.describe Patient, type: :model do

	before :all do
		Rails.application.load_seed
	end

	context 'Presence validations' do

		it "Complete" do
			hospital = create(:hospital)
			patient = Patient.create({
				name: 'Niv-Mizzet',
				birth_date: 4.years.ago,
				mother_name: 'Ur Dragon',
				medical_record: '8761238712',
				hospital: hospital
			})
			expect(patient).to be_valid
		end

		it "without name " do
			patient = build(:patient, name: nil)
			patient.save
			expect(patient).to be_invalid
		end

		it "without hospital" do
			patient = build(:patient, hospital: nil)
			patient.save
			expect(patient).to be_invalid
		end

		it "without birth_date" do
			patient = build(:patient, birth_date: nil)
			patient.save
			expect(patient).to be_invalid
		end

		it "without mother_name no HPP" do
			patient = build(:patient, mother_name: "   ")
			patient.save
			expect(patient).to be_valid
		end

		it "without mother_name in HPP" do
			patient = build(:patient, hospital: Hospital.HPP, mother_name: "    ")
			patient.save
			expect(patient).to be_invalid
		end

		it "without medical_record" do
			patient = build(:patient, medical_record: "")
			patient.save
			expect(patient).to be_valid
		end

		it "without medical_record and HPP" do
			patient = build(:patient, medical_record: nil, hospital: Hospital.HPP)
			patient.save
			expect(patient).to be_invalid
		end

		it "without medical_record and HPP empty" do
			patient = build(:patient, medical_record: "", hospital: Hospital.HPP)
			patient.save
			expect(patient).to be_invalid
		end

		it "without medical_record and HPP spaces" do
			patient = build(:patient, medical_record: "   ", hospital: Hospital.HPP)
			patient.save
			expect(patient).to be_invalid
		end

		it "without mother_name and medical_record" do
			patient = build(:patient, medical_record: "   ", mother_name: "   ")
			patient.save
			expect(patient).to be_valid
		end

		it "without mother_name and medical_record HPP" do
			patient = build(:patient, medical_record: "   ", mother_name: "   ", hospital: Hospital.HPP)
			patient.save
			expect(patient).to be_invalid
		end

		it "without observations" do
			patient = build(:patient, observations: nil)
			expect(patient).to be_valid
		end

	end

	context "validation_logics" do

		it "with duplicated medical_record and hospital" do
			patient = create(:patient)
			duplicated = build(:patient, medical_record: patient.medical_record, hospital: patient.hospital)
			duplicated.save
			expect(duplicated).to be_invalid
		end

		it "with duplicated medical_record but distinct hospital" do
			patient = create(:patient)
			duplicated = build(:patient, medical_record: patient.medical_record)
			duplicated.save
			expect(duplicated).to be_valid
		end

		it "with duplicated name, mother_name, birth_date, hospital" do
			patient = create(:patient)
			duplicated = build(:patient, name: patient.name, birth_date: patient.birth_date, mother_name: patient.mother_name, hospital: patient.hospital)
			duplicated.save
			expect(duplicated).to be_invalid
		end

		it "with name, birth_date, mother_name duplicated" do
			patient = create(:patient)
			duplicated = build(:patient, name: patient.name, birth_date: patient.birth_date, hospital: patient.hospital)
			duplicated.save
			expect(duplicated).to be_valid
		end

	end

	context 'Relations' do

		before :each do
			Rails.application.load_seed
		end

		it { should have_many :attendances }

		it { should have_many :samples }

		it { should have_many :subsamples }

	end


end
