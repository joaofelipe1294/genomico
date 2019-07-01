require 'rails_helper'

RSpec.describe HealthEnsurance, type: :model do

	context 'Validations' do

		it 'correct' do
			health_ensurance = create(:health_ensurance)
			expect(health_ensurance).to be_valid
		end 

		it 'without name' do
			health_ensurance = build(:health_ensurance, name: nil)
			expect(health_ensurance).to be_invalid
		end

		it 'duplicated name' do
			health_ensurance = create(:health_ensurance)
			duplicated = build(:health_ensurance, name: health_ensurance.name)
			duplicated.save
			expect(duplicated).to be_invalid
		end

	end

	context 'relations' do

		it { should have_many(:attendances) }

	end

end
