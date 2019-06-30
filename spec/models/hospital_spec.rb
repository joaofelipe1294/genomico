require 'rails_helper'

RSpec.describe Hospital, type: :model do

	context 'Test validations' do

		it 'new valid hospital' do 
			hospital = create(:hospital)
			expect(hospital).to be_valid
		end

		it 'without name' do
			hospital = build(:hospital, name: nil)
			hospital.save
			expect(hospital).to be_invalid
		end

		it 'duplicated name' do
			hospital = create(:hospital)
			duplicated_hospital = build(:hospital, name: hospital.name)
			duplicated_hospital.save
			expect(duplicated_hospital).to be_invalid
		end

	end

end
