require 'rails_helper'

RSpec.describe Brand, type: :model do

  it "complete" do
    brand = build(:brand, name: "Apple")
    expect(brand).to be_valid
  end

  it "without name" do
    brand = build(:brand, name: nil)
    expect(brand).to be_invalid
    brand = build(:brand, name: "")
    expect(brand).to be_invalid
  end

  it "duplicated name" do
    brand = create(:brand, name: "Apple")
    duplicated = build(:brand, name: "Apple")
    expect(duplicated).to be_invalid
  end

end
