require 'rails_helper'

RSpec.describe BottleStatusKind, type: :model do

  it "complete" do
    bottle_status_kind = BottleStatusKind.new(name: 'Some name')
    expect(bottle_status_kind).to be_valid
  end

  it "duplicated" do
    bottle_status_kind = BottleStatusKind.create(name: 'Em estoque')
    duplicated = BottleStatusKind.new(name: 'Em estoque')
    expect(duplicated).to be_invalid
  end

  it "without name" do
    bottle_status_kind = BottleStatusKind.new
    expect(bottle_status_kind).to be_invalid
  end

  context "constants" do

    before :each do
      Rails.application.load_seed
    end

    it "in_stock" do
      expect(BottleStatusKind.IN_STOCK).to eq BottleStatusKind.find_by(name: 'Em estoque')
    end

    it "in_use" do
      expect(BottleStatusKind.IN_USE).to eq BottleStatusKind.find_by(name: 'Em uso')
    end

    it "in_quarentine" do
      expect(BottleStatusKind.IN_QUARENTINE).to eq BottleStatusKind.find_by(name: 'Em quarentena')
    end

  end


end
