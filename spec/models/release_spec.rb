require 'rails_helper'

RSpec.describe Release, type: :model do

  it "correct" do
    release = build(:release)
    expect(release).to be_valid
    expect(release.is_active).to be_truthy
  end

  context "without values" do

    it "name" do
      release = build(:release, name: "")
      expect(release).to be_invalid
    end

    it "tag" do
      release = build(:release, tag: "")
      expect(release).to be_invalid
    end

    it "message" do
      release = build(:release, message: "")
      expect(release).to be_invalid
    end

  end

  context "uniqueness" do

    before(:each) { @release = create(:release) }

    after(:each) { expect(@duplicated).to be_invalid }

    it "duplicated name" do
      @duplicated = build(:release, name: @release.name)
    end

    it "duplicated tag" do
      @duplicated = build(:release, tag: @release.tag)
    end

  end

end
