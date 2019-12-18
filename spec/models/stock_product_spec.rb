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

    it "total_aviable" do
      stock_product = build(:stock_product, total_aviable: nil)
      expect(stock_product).to be_valid
      expect(stock_product.total_aviable).to eq 0
    end

    it "usage_per_test" do
      stock_product = build(:stock_product, usage_per_test: nil)
      expect(stock_product).to be_valid
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

  context "display_field" do

    before :all do
      Rails.application.load_seed
    end

    it "display_field" do
      stock_product = build(:stock_product, field: Field.IMUNOFENO)
      expect(stock_product.display_field).to eq "<label>#{Field.IMUNOFENO.name}</label>".html_safe
    end

    it "display_field without field" do
      stock_product = build(:stock_product, field: nil)
      expect(stock_product.display_field).to eq "<label>Compartilhado</label>".html_safe
    end

  end

end
