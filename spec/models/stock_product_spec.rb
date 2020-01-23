require 'rails_helper'

RSpec.describe StockProduct, type: :model do

  before :all do
    Rails.application.load_seed
    create(:brand)
  end

  it "complete" do
    stock_product = build(:stock_product)
    expect(stock_product).to be_valid
  end

  context "presence validatons" do

    it "name" do
      stock_product = build(:stock_product, name: '')
      expect(stock_product).to be_invalid
    end

    it "field" do
      stock_product = build(:stock_product, field: nil)
      expect(stock_product).to be_valid
    end

    it "first_warn_at" do
      stock_product = build(:stock_product, first_warn_at: '')
      expect(stock_product).to be_valid
    end

    it "danger_warn_at" do
      stock_product = build(:stock_product, danger_warn_at: '')
      expect(stock_product).to be_valid
    end

    it "mv_code" do
      stock_product = build(:stock_product, mv_code: '')
      expect(stock_product).to be_valid
    end

  end

  context "uniqueness validations" do

    before :each do
      @stock_product = create(:stock_product)
    end

    after :each do
      expect(@duplicated).to be_invalid
    end

    it "name" do
      @duplicated = build(:stock_product, name: @stock_product.name)
    end

    it "mv_code" do
      @duplicated = build(:stock_product, mv_code: @stock_product.mv_code)
    end

  end

  it "two nil mv_codes" do
    create(:stock_product, mv_code: nil)
    second_stock_product_without_mv_code = build(:stock_product, mv_code: nil)
    expect(second_stock_product_without_mv_code).to be_valid
  end

  it { should belong_to :field }

end
