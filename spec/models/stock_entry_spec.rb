require 'rails_helper'

RSpec.describe StockEntry, type: :model do

  def setup
    Rails.application.load_seed
    create(:user)
    create(:reagent)
  end

  before(:each) { setup }

  it "complete" do
    stock_entry = build(:stock_entry)
    expect(stock_entry).to be_valid
  end

  context "wihtout values" do

    before(:each) { @stock_entry = build(:stock_entry) }

    after(:each) { expect(@stock_entry).to be_invalid }

    it "reagent" do
      @stock_entry.reagent = nil
    end

    it "lot" do
      @stock_entry.lot = ""
    end

    it "entry_date" do
      @stock_entry.entry_date = nil
    end

    it "current_state" do
      @stock_entry.current_state = nil
    end

    it "location" do
      @stock_entry.location = ""
    end

    it "responsible" do
      @stock_entry.responsible = nil
    end

  end

  context "shelf_life validation" do

    before :each do
      setup
      @stock_entry = build(:stock_entry)
    end

    it "with shelf_life" do
      @stock_entry.has_shelf_life = true
      @stock_entry.shelf_life = 2.years.from_now
      expect(@stock_entry).to be_valid
    end

    it "with has_shelf_life but without a date" do
      @stock_entry.has_shelf_life = true
      @stock_entry.shelf_life = nil
      expect(@stock_entry).to be_invalid
    end

    it "with has_shelf_life but without a date" do
      @stock_entry.has_shelf_life = false
      @stock_entry.shelf_life = nil
      expect(@stock_entry).to be_valid
    end

  end

  context "default values" do

    before(:each) { setup }

    it "not expired" do
      stock_entry = build(:stock_entry, shelf_life: 3.years.from_now)
      expect(stock_entry).to be_valid
      expect(stock_entry.is_expired).to eq false
    end

    it "expired" do
      stock_entry = build(:stock_entry, shelf_life: 2.months.ago)
      expect(stock_entry).to be_valid
      expect(stock_entry.is_expired).to eq true
    end

    it "has_shelf_life = false" do
      stock_entry = build(:stock_entry, has_shelf_life: false)
      expect(stock_entry).to be_valid
      expect(stock_entry.is_expired).to eq false
    end

    it "with has_shelf_life but without date" do
      stock_entry = build(:stock_entry, has_shelf_life: true, shelf_life: nil)
      expect(stock_entry).to be_invalid
      expect(stock_entry.is_expired).to eq false
    end

  end

end
