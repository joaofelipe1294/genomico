require 'rails_helper'

RSpec.describe Product, type: :model do

    def setup
      Rails.application.load_seed
      create(:user)
      create(:reagent)
    end

    before(:each) { setup }

    it "complete" do
      product = build(:product)
      expect(product).to be_valid
    end

    context "wihtout values" do

      before(:each) { @product = build(:product) }

      after(:each) { expect(@product).to be_invalid }

      it "reagent" do
        @product.reagent = nil
      end

      it "lot" do
        @product.lot = ""
      end

      it "current_state" do
        @product.current_state = nil
      end

      it "location" do
        @product.location = ""
      end

    end

    context "shelf_life validation" do

      before :each do
        setup
        @product = build(:product)
      end

      it "with shelf_life" do
        @product.has_shelf_life = true
        @product.shelf_life = 2.years.from_now
        expect(@product).to be_valid
      end

      it "with has_shelf_life but without a date" do
        @product.has_shelf_life = true
        @product.shelf_life = nil
        expect(@product).to be_invalid
      end

      it "with has_shelf_life but without a date" do
        @product.has_shelf_life = false
        @product.shelf_life = nil
        expect(@product).to be_valid
      end

    end

    context "default values" do

      before(:each) { setup }

      it "not expired" do
        product = build(:product, shelf_life: 3.years.from_now)
        expect(product).to be_valid
        expect(product.is_expired).to eq false
      end

      it "expired" do
        product = build(:product, shelf_life: 2.months.ago)
        expect(product).to be_valid
        expect(product.is_expired).to eq true
      end

      it "has_shelf_life = false" do
        product = build(:product, has_shelf_life: false)
        expect(product).to be_valid
        expect(product.is_expired).to eq false
      end

      it "with has_shelf_life but without date" do
        product = build(:product, has_shelf_life: true, shelf_life: nil)
        expect(product).to be_invalid
        expect(product.is_expired).to eq false
      end

    end

    context "tag generation" do

      before(:each) { setup }

      it "ok" do
        create(:reagent, field: Field.BIOMOL)
        product = create(:product, reagent: Reagent.where(field: Field.BIOMOL).first, has_tag: true, tag: nil)
        expect(product).to be_valid
        expect(product.tag).to eq "#{Field.BIOMOL.name[0,3]}#{1}"
      end

      it "without reagent" do
        product = build(:product, reagent: nil)
        expect(product).to be_invalid
      end

      it "distinct fields" do
        create(:reagent, field: Field.BIOMOL)
        product_biomol = create(:product, reagent: Reagent.where(field: Field.BIOMOL).first, has_tag: true, tag: nil)
        create(:reagent, field: Field.IMUNOFENO)
        product_imunofeno = create(:product, reagent: Reagent.where(field: Field.IMUNOFENO).first, has_tag: true, tag: nil)
        create(:reagent, field: nil)
        product_shared = create(:product, reagent: Reagent.where(field: nil).first, has_tag: true, tag: nil)
        expect(product_biomol).to be_valid
        expect(product_imunofeno).to be_valid
        expect(product_shared).to be_valid
        expect(product_biomol.tag).to eq "#{Field.BIOMOL.name[0,3]}#{1}"
        expect(product_imunofeno.tag).to eq "#{Field.IMUNOFENO.name[0,3]}#{1}"
        expect(product_shared.tag).to eq "ALL#{1}"
      end

      it "same area entries" do
        reagent = create(:reagent, field: Field.BIOMOL)
        first_product = create(:product, reagent: reagent, has_tag: true, tag: nil)
        second_product = create(:product, reagent: reagent, has_tag: true, tag: nil)
        expect(first_product).to be_valid
        expect(second_product).to be_valid
        expect(first_product.tag).to eq "#{Field.BIOMOL.name[0, 3]}#{1}"
        expect(second_product.tag).to eq "#{Field.BIOMOL.name[0, 3]}#{2}"
      end

    end

    context "amount validation" do

      before(:each) { setup }

      after(:each) { expect(@product).to be_invalid }

      it "wihtou amount value" do
        @product = build(:product, amount: nil)
      end

      it "with zero on amount value" do
        @product = build(:product, amount: 0)
      end

    end

end
