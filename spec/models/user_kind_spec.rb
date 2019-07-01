require 'rails_helper'

RSpec.describe UserKind, type: :model do

  context 'User_Kind validations' do

  	it 'Create correct.' do
  		user_kind = create(:user_kind)
  		expect(user_kind).to be_valid
		end

		it 'without name' do
			user_kind = build(:user_kind, name: nil)
			user_kind.save
			expect(user_kind).to be_invalid
		end

		it 'with duplicated name' do
			user_kind = create(:user_kind)
			duplicated = build(:user_kind, name: user_kind.name)
			duplicated.save
			expect(duplicated).to be_invalid
		end

		it { should have_many(:users) }

	end 

end
