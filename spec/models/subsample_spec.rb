require 'rails_helper'

RSpec.describe Subsample, type: :model do

	context 'Validations' do

		it 'Correct' do
			subsample = create(:subsample)
			expect(subsample).to be_valid
		end

		it 'without storage_location' do
			subsample = build(:subsample)
			subsample.save
			expect(subsample).to be_valid
		end

		it 'without sample' do
			subsample = build(:subsample, sample: nil)
			subsample.save
			expect(subsample).to be_invalid
		end

		it 'without collection_date' do
			subsample = build(:subsample, collection_date: nil)
			subsample.save
			expect(subsample).to be_valid
		end

		it 'without subsample_kind' do
			subsample = build(:subsample, subsample_kind: nil)
			subsample.save
			expect(subsample).to be_invalid
		end

		it 'without refference_label' do
			subsample = build(:subsample, refference_label: nil)
			subsample.save
			expect(subsample).to be_valid
		end

	end

	context 'Relations' do

		it { should belong_to(:sample) }

		it { should belong_to(:subsample_kind) }

		it { should have_one(:qubit_report) }

		it { should have_one(:nanodrop_report) }

		it { should have_and_belong_to_many(:work_maps) }

		it { should accept_nested_attributes_for(:qubit_report) }

		it { should accept_nested_attributes_for(:nanodrop_report) }

		it { should have_many :internal_codes }

	end

	context 'Before_save' do

		it 'add_default_values' do
			subsample_kind = create(:subsample_kind, name: 'DNA', acronym: 'DNA', refference_index: 5)
			subsample = create(
				:subsample,
				subsample_kind: subsample_kind,
				collection_date: Date.today.year
			)
			subsample = Subsample.find subsample.id
			expect(subsample).to be_valid
			expect(subsample.refference_label).to eq("#{Date.today.year.to_s.slice(2, 3)}-DNA-0006")
		end

	end

end
