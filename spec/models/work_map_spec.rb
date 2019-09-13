require 'rails_helper'

RSpec.describe WorkMap, type: :model do

	context 'Validations' do

		it 'correct' do
			work_map = create(:work_map)
			expect(work_map).to be_valid
		end

		it 'without name' do
			work_map = build(:work_map, name: nil)
			work_map.save
			expect(work_map).to be_invalid
		end

		it 'duplicated name' do
			work_map = create(:work_map)
			duplicated = build(:work_map, name: work_map.name)
			duplicated.save
			expect(duplicated).to be_invalid
		end

		it 'without map' do
			work_map = build(:work_map, map: nil)
			work_map.save
			expect(work_map).to be_invalid
		end

	end

	context 'Relations' do

		it { should have_and_belong_to_many(:attendances) }

	end

end
