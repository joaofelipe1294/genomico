require 'rails_helper'

RSpec.describe User, type: :model do

	context 'User validations' do

		it 'correct user' do
			user = create(:user)
			expect(user).to be_valid
		end

		it 'without login' do
			user = build(:user, login: nil)
			user.save
			expect(user).to be_invalid
		end

		it 'with duplicated login' do
			user = create(:user)
			duplicated = build(:user, login: user.login)
			duplicated.save
			expect(duplicated).to be_invalid
		end

		it 'without password' do
			user = build(:user, password: nil)
			user.save
			expect(user).to be_invalid
		end

		it 'without name' do
			user = build(:user, name: nil)
			user.save
			expect(user).to be_invalid
		end

		it 'duplicated name' do
			user = create(:user)
			duplicated = build(:user, name: user.name)
			duplicated.save
			expect(duplicated).to be_invalid
		end

	end

	context 'properties validations' do

		 it { should have_secure_password }

		 it { should have_and_belong_to_many :fields }

	end

	context 'after_initialize' do

		it 'without is_active' do
			user = create(:user, is_active: nil)
			user = User.find user.id
			expect(user.is_active).to eq(true)
		end

	end

end
