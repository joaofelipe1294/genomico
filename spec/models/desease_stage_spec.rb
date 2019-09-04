require 'rails_helper'

RSpec.describe DeseaseStage, type: :model do

	before :all do
		Rails.application.load_seed
	end

	context 'Desease_stage validations' do

		it 'correct desease_stage' do
			desease_stage = create(:desease_stage, name: 'This name is original')
			expect(desease_stage).to be_valid
		end

		it 'without name' do
			desease_stage = build(:desease_stage, name: nil)
			desease_stage.save
			expect(desease_stage).to be_invalid
		end

		it 'duplicated name' do
			desease_stage = create(:desease_stage, name: 'This name is original too')
			duplicated = build(:desease_stage, name: desease_stage.name)
			duplicated.save
			expect(duplicated).to be_invalid
		end

	end

	context 'Desease_stage relations' do

		 it { should have_many(:attendances) }

 	end

	context "constants" do

		it "recaida" do
			expect(DeseaseStage.RETURN).to eq DeseaseStage.find_by name: 'Recaída'
		end

		it "DRM" do
			expect(DeseaseStage.DRM).to eq DeseaseStage.find_by name: 'DRM'
		end

		it "diagnostico" do
			expect(DeseaseStage.DIAGNOSIS).to eq DeseaseStage.find_by name: 'Diagnóstico'
		end

	end

end
