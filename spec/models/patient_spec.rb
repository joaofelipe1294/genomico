require 'rails_helper'

RSpec.describe Patient, type: :model do

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
			hpp = Hospital.create(name: "Hospital Pequeno Príncipe")
			patient = build(:patient, hospital: hpp, mother_name: "    ")
			patient.save
			expect(patient).to be_invalid
		end

		it "without medical_record" do
			patient = build(:patient, medical_record: "")
			patient.save
			expect(patient).to be_valid
		end

		it "without medical_record and HPP" do
			hpp = Hospital.create(name: "Hospital Pequeno Príncipe")
			patient = build(:patient, medical_record: nil, hospital: hpp)
			patient.save
			expect(patient).to be_invalid
		end

		it "without medical_record and HPP empty" do
			hpp = Hospital.create(name: "Hospital Pequeno Príncipe")
			patient = build(:patient, medical_record: "", hospital: hpp)
			patient.save
			expect(patient).to be_invalid
		end

		it "without medical_record and HPP spaces" do
			hpp = Hospital.create(name: "Hospital Pequeno Príncipe")
			patient = build(:patient, medical_record: "   ", hospital: hpp)
			patient.save
			expect(patient).to be_invalid
		end

		it "without mother_name and medical_record" do
			patient = build(:patient, medical_record: "   ", mother_name: "   ")
			patient.save
			expect(patient).to be_valid
		end

		it "without mother_name and medical_record HPP" do
			hpp = Hospital.create(name: "Hospital Pequeno Príncipe")
			patient = build(:patient, medical_record: "   ", mother_name: "   ", hospital: hpp)
			patient.save
			expect(patient).to be_invalid
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

		it { should have_many(:attendances) }

		it { should belong_to(:hospital) }

	end




















































	#
	# context 'Validations' do
	#
	# 	it 'correct' do
	# 		patient = build(:patient)
	# 		patient.save
	# 		expect(patient).to be_valid
	# 	end
	#
	# 	it 'without name' do
	# 		patient = build(:patient, name: nil)
	# 		patient.save
	# 		expect(patient).to be_invalid
	# 	end
	#
	# 	it 'without medical_record and other hospital' do
	# 		patient = build(:patient, medical_record: nil)
	# 		patient.save
	# 		expect(patient).to be_valid
	# 	end
	#
	# 	it 'withou medical_record and HPP' do
	# 		hpp = Hospital.create(name: "Hospital Pequeno Príncipe")
	# 		patient = build(:patient, medical_record: nil, hospital: hpp)
	# 		patient.save
	# 		expect(patient).to be_invalid
	# 	end
	#
	# 	it 'duplicated medical_record' do
	# 		patient = create(:patient)
	# 		duplicated = build(:patient,
	# 			medical_record: patient.medical_record,
	# 			hospital: patient.hospital
	# 		)
	# 		duplicated.save
	# 		expect(duplicated).to be_invalid
	# 	end
	#
	# 	it 'without mother_name and other hospital' do
	# 		patient = build(:patient, mother_name: nil)
	# 		patient.save
	# 		expect(patient).to be_valid
	# 	end
	#
	# 	it 'withou mother name and HPP' do
	# 		hpp = Hospital.create(name: "Hospital Pequeno Príncipe")
	# 		patient = build(:patient, mother_name: nil, hospital: hpp)
	# 		patient.valid?
	# 		expect(patient).to be_invalid
	# 	end
	#
	# 	it 'without hospital' do
	# 		patient = build(:patient, hospital: nil)
	# 		patient.save
	# 		expect(patient).to be_invalid
	# 	end
	#
	# 	it 'with same name, birth_date, mother_name and hospital' do
	# 		patient = create(:patient)
	# 		duplicated = build(:patient,
	# 			name: patient.name,
	# 			mother_name: patient.mother_name,
	# 			birth_date: patient.birth_date,
	# 			hospital: patient.hospital
	# 		)
	# 		duplicated.save
	# 		expect(duplicated).to be_invalid
	# 	end
	#
	# end
	#


end
