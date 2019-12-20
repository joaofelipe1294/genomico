require 'rails_helper'

RSpec.describe StockOut, type: :model do

  before :each do
    Rails.application.load_seed
    create(:user)
    create(:brand)
    create(:stock_product)
    @product = create(:product)
    create(:stock_entry, product: @product)
  end

  it "complete" do
    stock_out = build(:stock_out, product: @product)
    expect(stock_out).to be_valid
  end

  it "without product" do
    stock_out = build(:stock_out, product: nil)
    expect(stock_out).to be_invalid
  end

  it "without date" do
    stock_out = build(:stock_out, product: @product, date: nil)
    expect(stock_out).to be_invalid
  end

  it "without stock_product" do
    stock_out = build(:stock_out, product: @product, stock_product: nil)
    expect(stock_out).to be_valid
  end

  it "without responsible" do
    stock_out = build(:stock_out, responsible: nil)
    expect(stock_out).to be_invalid
  end

end
