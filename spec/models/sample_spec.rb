require 'rails_helper'

RSpec.describe Sample, type: :model do

	context 'Validations' do

		it 'Complete' do
			sample = create(:sample)
			expect(sample).to be_valid
		end

		it 'without sample_kind' do
			sample = build(:sample, sample_kind: nil)
			sample.save
			expect(sample).to be_invalid
		end

		it 'without has_subsample' do
			sample = build(:sample, has_subsample: nil)
			sample.save
			expect(sample).to be_valid
		end

		it 'without entry_date' do
			sample = build(:sample, entry_date: nil)
			sample.save
			expect(sample).to be_valid
		end

		it 'without collection_date' do
			sample = build(:sample, collection_date: nil)
			sample.save
			expect(sample).to be_invalid
		end

		it 'without refference_label' do
			sample = build(:sample, refference_label: nil)
			sample.save
			expect(sample).to be_valid
		end

		it 'without bottles_number' do
			sample = build(:sample, bottles_number: nil)
			sample.save
			expect(sample).to be_invalid
		end

		it 'without storage_location' do
			sample = build(:sample, storage_location: nil)
			sample.save
			expect(sample).to be_valid
		end

	end

	context 'Relations' do

		it { should belong_to(:attendance) }

		it { should belong_to(:sample_kind) }

		it { should have_many(:subsamples) }

		it { should have_many(:exams) }

		it {should have_and_belong_to_many(:work_maps) }

	end

	context 'Initializers' do

		it 'entry_date' do
			sample = Sample.new
			expect(sample.entry_date).to eq(Date.today)
		end

		it 'has_subsample' do
			sample = Sample.new
			expect(sample.has_subsample).to be_equal(false)
		end

	end

	context 'Before_save' do

		it 'set_refference_label' do
			sample_kind = create(:sample_kind, name: 'Liquor', acronym: 'LQ', refference_index: 0)
			sample = create(:sample, sample_kind: sample_kind)
			expect(sample.refference_label).to be
			expect(sample.refference_label).to eq("#{Date.today.year.to_s.slice(2, 3)}-LQ-00001")
		end

	end

end
