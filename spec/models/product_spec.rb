require 'rails_helper'

RSpec.describe Product, type: :model do

    def setup
      Rails.application.load_seed
      create(:user)
      create(:reagent)
      
    end

    before(:each) { setup }

    # it "complete" do
    #   stock_entry = build(:stock_entry)
    #   expect(stock_entry).to be_valid
    # end
    #
    # context "wihtout values" do
    #
    #   before(:each) { @stock_entry = build(:stock_entry) }
    #
    #   after(:each) { expect(@stock_entry).to be_invalid }

      # it "reagent" do
      #   @stock_entry.reagent = nil
      # end

      # it "lot" do
      #   @stock_entry.lot = ""
      # end

      # it "entry_date" do
      #   @stock_entry.entry_date = nil
      # end

      # it "current_state" do
      #   @stock_entry.current_state = nil
      # end
      #
      # it "location" do
      #   @stock_entry.location = ""
      # end

    #   it "responsible" do
    #     @stock_entry.responsible = nil
    #   end
    #
    # end
    #
    # context "shelf_life validation" do
    #
    #   before :each do
    #     setup
    #     @stock_entry = build(:stock_entry)
    #   end

      # it "with shelf_life" do
      #   @stock_entry.has_shelf_life = true
      #   @stock_entry.shelf_life = 2.years.from_now
      #   expect(@stock_entry).to be_valid
      # end

      # it "with has_shelf_life but without a date" do
      #   @stock_entry.has_shelf_life = true
      #   @stock_entry.shelf_life = nil
      #   expect(@stock_entry).to be_invalid
      # end

      # it "with has_shelf_life but without a date" do
      #   @stock_entry.has_shelf_life = false
      #   @stock_entry.shelf_life = nil
      #   expect(@stock_entry).to be_valid
      # end
    #
    # end

    # context "default values" do
    #
    #   before(:each) { setup }
    #
    #   it "not expired" do
    #     stock_entry = build(:stock_entry, shelf_life: 3.years.from_now)
    #     expect(stock_entry).to be_valid
    #     expect(stock_entry.is_expired).to eq false
    #   end
    #
    #   it "expired" do
    #     stock_entry = build(:stock_entry, shelf_life: 2.months.ago)
    #     expect(stock_entry).to be_valid
    #     expect(stock_entry.is_expired).to eq true
    #   end
    #
    #   it "has_shelf_life = false" do
    #     stock_entry = build(:stock_entry, has_shelf_life: false)
    #     expect(stock_entry).to be_valid
    #     expect(stock_entry.is_expired).to eq false
    #   end
    #
    #   it "with has_shelf_life but without date" do
    #     stock_entry = build(:stock_entry, has_shelf_life: true, shelf_life: nil)
    #     expect(stock_entry).to be_invalid
    #     expect(stock_entry.is_expired).to eq false
    #   end
    #
    # end
    #
    # context "tag generation" do
    #
    #   before(:each) { setup }
    #
    #   it "ok" do
    #     create(:reagent, field: Field.BIOMOL)
    #     stock_entry = create(:stock_entry, reagent: Reagent.where(field: Field.BIOMOL).first, has_tag: true, tag: nil)
    #     expect(stock_entry).to be_valid
    #     expect(stock_entry.tag).to eq "#{Field.BIOMOL.name[0,3]}#{1}"
    #   end
    #
    #   it "without reagent" do
    #     stock_entry = build(:stock_entry, reagent: nil)
    #     expect(stock_entry).to be_invalid
    #   end
    #
    #   it "distinct fields" do
    #     create(:reagent, field: Field.BIOMOL)
    #     stock_entry_biomol = create(:stock_entry, reagent: Reagent.where(field: Field.BIOMOL).first, has_tag: true, tag: nil)
    #     create(:reagent, field: Field.IMUNOFENO)
    #     stock_entry_imunofeno = create(:stock_entry, reagent: Reagent.where(field: Field.IMUNOFENO).first, has_tag: true, tag: nil)
    #     create(:reagent, field: nil)
    #     stock_entry_shared = create(:stock_entry, reagent: Reagent.where(field: nil).first, has_tag: true, tag: nil)
    #     expect(stock_entry_biomol).to be_valid
    #     expect(stock_entry_imunofeno).to be_valid
    #     expect(stock_entry_shared).to be_valid
    #     expect(stock_entry_biomol.tag).to eq "#{Field.BIOMOL.name[0,3]}#{1}"
    #     expect(stock_entry_imunofeno.tag).to eq "#{Field.IMUNOFENO.name[0,3]}#{1}"
    #     expect(stock_entry_shared.tag).to eq "ALL#{1}"
    #   end
    #
    #   it "same area entries" do
    #     reagent = create(:reagent, field: Field.BIOMOL)
    #     first_entrance = create(:stock_entry, reagent: reagent, has_tag: true, tag: nil)
    #     second_entrance = create(:stock_entry, reagent: reagent, has_tag: true, tag: nil)
    #     expect(first_entrance).to be_valid
    #     expect(second_entrance).to be_valid
    #     expect(first_entrance.tag).to eq "#{Field.BIOMOL.name[0, 3]}#{1}"
    #     expect(second_entrance.tag).to eq "#{Field.BIOMOL.name[0, 3]}#{2}"
    #   end
    #
    # end

    # context "amount validation" do
    #
    #   before(:each) { setup }
    #
    #   after(:each) { expect(@stock_entry).to be_invalid }
    #
    #   it "wihtou amount value" do
    #     @stock_entry = build(:stock_entry, amount: nil)
    #   end
    #
    #   it "with zero on amount value" do
    #     @stock_entry = build(:stock_entry, amount: 0)
    #   end
    #
    # end


end
