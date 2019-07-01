require 'rails_helper'

RSpec.describe SampleKind, type: :model do

	context 'validations' do

		it 'correct' do
			sample_kind = create(:sample_kind)
			expect(sample_kind).to be_valid
		end

		it 'without name' do
			sample_kind = build(:sample_kind, name: nil)
			sample_kind.save
			expect(sample_kind).to be_invalid
		end

		it 'duplicated name' do
			sample_kind = create(:sample_kind)
			duplicated = build(:sample_kind, name: sample_kind.name)
			duplicated.save
			expect(duplicated).to be_invalid
		end

		it 'without acronym' do
			sample_kind = build(:sample_kind, acronym: nil)
			sample_kind.save
			expect(sample_kind).to be_invalid
		end

		it 'duplicated acronym' do
			sample_kind = create(:sample_kind)
			duplicated = build(:sample_kind, acronym: sample_kind.acronym)
			duplicated.save
			expect(duplicated).to be_invalid
		end

	end

	context 'relations' do

		it {should have_many(:samples)}

	end

	context 'Before_create' do

		it 'set_refference_index' do
			sample_kind = create(:sample_kind, refference_index: nil)
			sample_kind = SampleKind.find sample_kind.id
			expect(sample_kind).to be_valid
			expect(sample_kind.refference_index).to eq(0)
		end

	end

end
