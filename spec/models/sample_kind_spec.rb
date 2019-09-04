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

	context "constants" do

		before :all do
			Rails.application.load_seed
		end

		it "biopsy" do
			expect(SampleKind.BIOPSY).to eq SampleKind.find_by name: 'Biópsia de tecidos.'
		end

		it "swab" do
			expect(SampleKind.SWAB).to eq SampleKind.find_by name: 'Swab bucal.'
		end

		it "paraffin_block" do
			expect(SampleKind.PARAFFIN_BLOCK).to eq SampleKind.find_by name: 'Bloco de parafina.'
		end

		it "liquor" do
			expect(SampleKind.LIQUOR).to eq SampleKind.find_by name: 'Liquor'
		end

		it "peripherical_blood" do
			expect(SampleKind.PERIPHERAL_BLOOD).to eq SampleKind.find_by name: 'Sangue periférico'
		end

		it "bone_merrow" do
			expect(SampleKind.BONE_MARROW).to eq SampleKind.find_by name: 'Medula óssea'
		end

	end

end
