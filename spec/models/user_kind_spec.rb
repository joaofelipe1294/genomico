require 'rails_helper'

RSpec.describe UserKind, type: :model do

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

  context "class methods" do

    before :each do
      Rails.application.load_seed
    end

    it "ADMIN method" do
      expect(UserKind.ADMIN).to eq UserKind.find_by name: 'admin'
    end

    it "USER method" do
      expect(UserKind.USER).to eq UserKind.find_by name: 'user'
    end

  end

end
