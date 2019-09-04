require 'rails_helper'

RSpec.describe SubsampleKind, type: :model do

  context 'Sample_Kinds_Validations' do

  	it 'correct sample_kind creation' do
  		subsample_kind = create(:subsample_kind)
  		expect(subsample_kind).to be_valid
		end

		it 'without name' do
			subsample_kind = build(:subsample_kind, name: nil)
			subsample_kind.save
			expect(subsample_kind).to be_invalid
		end

		it 'duplicated name' do
			subsample_kind = create(:subsample_kind)
			duplicated = build(:subsample_kind, name: subsample_kind.name)
			duplicated.save
			expect(duplicated).to be_invalid
		end

		it 'without acronym' do
			subsample_kind = build(:subsample_kind, acronym: nil)
			subsample_kind.save
			expect(subsample_kind).to be_invalid
		end

		it 'duplicated acronym' do
			subsample_kind = create(:subsample_kind)
			duplicated = build(:subsample_kind, acronym: subsample_kind.acronym)
			duplicated.save
			expect(duplicated).to be_invalid
		end

	end

  context "Constants" do

    before :all do
      Rails.application.load_seed
    end

    it "Pellet de FISH" do
      expect(SubsampleKind.PELLET).to eq SubsampleKind.find_by name: 'Pellet de FISH'
    end

    it "RNA" do
      expect(SubsampleKind.RNA).to eq SubsampleKind.find_by name: 'RNA'
    end

    it "DNA" do
      expect(SubsampleKind.DNA).to eq SubsampleKind.find_by name: 'DNA'
    end

    it "viral_dna" do
      expect(SubsampleKind.VIRAL_DNA).to eq SubsampleKind.find_by name: 'DNA viral'
    end

  end

end
