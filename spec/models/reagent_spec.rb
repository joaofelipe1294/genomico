require 'rails_helper'

RSpec.describe Reagent, type: :model do

  before :all do
    Rails.application.load_seed
  end

  it "complete" do
    reagent = build(:reagent)
    expect(reagent).to be_valid
  end

  context "presence validatons" do

    it "product_description" do
      reagent = build(:reagent, product_description: '')
      expect(reagent).to be_invalid
    end

    it "name" do
      reagent = build(:reagent, name: '')
      expect(reagent).to be_invalid
    end

    it "stock_itens" do
      reagent = build(:reagent, stock_itens: nil)
      expect(reagent).to be_valid
      expect(reagent.stock_itens).to eq 0
    end

    it "usage_per_test" do
      reagent = build(:reagent, usage_per_test: nil)
      expect(reagent).to be_valid
    end

    it "brand" do
      reagent = build(:reagent, brand: '')
      expect(reagent).to be_invalid
    end

    it "field" do
      reagent = build(:reagent, field: nil)
      expect(reagent).to be_valid
    end

    it "first_warn_at" do
      reagent = build(:reagent, first_warn_at: '')
      expect(reagent).to be_valid
    end

    it "danger_warn_at" do
      reagent = build(:reagent, danger_warn_at: '')
      expect(reagent).to be_valid
    end

    it "mv_code" do
      reagent = build(:reagent, mv_code: '')
      expect(reagent).to be_invalid
    end

    it "product_code" do
      reagent = build(:reagent, product_code: '')
      expect(reagent).to be_invalid
    end

    it "total_aviable" do
      reagent = build(:reagent, total_aviable: nil)
      expect(reagent).to be_valid
      expect(reagent.total_aviable).to eq 0
    end

  end

  context "uniqueness validations" do

    before :each do
      @reagent = create(:reagent)
    end

    after :each do
      expect(@duplicated).to be_invalid
    end

    it "product_description" do
      @duplicated = build(:reagent, product_description: @reagent.product_description)
    end

    it "name" do
      @duplicated = build(:reagent, name: @reagent.name)
    end

    it "mv_code" do
      @duplicated = build(:reagent, mv_code: @reagent.mv_code)
    end

    it "product_code" do
      @duplicated = build(:reagent, product_code: @reagent.product_code)
    end

  end

  it { should belong_to :field }

end
