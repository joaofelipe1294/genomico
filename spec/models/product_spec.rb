require 'rails_helper'

RSpec.describe Product, type: :model do

    def setup
      Rails.application.load_seed
      create(:user)
      create(:brand)
      create(:stock_product)
    end

    before(:each) { setup }

    it "complete" do
      product = build(:product)
      expect(product).to be_valid
    end

    context "wihtout values" do

      before(:each) { @product = build(:product) }

      after(:each) { expect(@product).to be_invalid }

      it "stock_product" do
        @product.stock_product = nil
      end

      it "lot" do
        @product.lot = ""
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
        create(:stock_product, field: Field.BIOMOL)
        product = create(:product, stock_product: StockProduct.where(field: Field.BIOMOL).first, has_tag: true, tag: nil)
        expect(product).to be_valid
        expect(product.tag).to eq "#{Field.BIOMOL.name[0,3]}#{1}"
      end

      it "without stock_product" do
        product = build(:product, stock_product: nil)
        expect(product).to be_invalid
      end

      it "distinct fields" do
        create(:stock_product, field: Field.BIOMOL)
        product_biomol = create(:product, stock_product: StockProduct.where(field: Field.BIOMOL).first, has_tag: true, tag: nil)
        create(:stock_product, field: Field.IMUNOFENO)
        product_imunofeno = create(:product, stock_product: StockProduct.where(field: Field.IMUNOFENO).first, has_tag: true, tag: nil)
        create(:stock_product, field: nil)
        product_shared = create(:product, stock_product: StockProduct.where(field: nil).first, has_tag: true, tag: nil)
        expect(product_biomol).to be_valid
        expect(product_imunofeno).to be_valid
        expect(product_shared).to be_valid
        expect(product_biomol.tag).to eq "#{Field.BIOMOL.name[0,3]}#{1}"
        expect(product_imunofeno.tag).to eq "#{Field.IMUNOFENO.name[0,3]}#{1}"
        expect(product_shared.tag).to eq "ALL#{1}"
      end

      it "same area entries" do
        stock_product = create(:stock_product, field: Field.BIOMOL)
        first_product = create(:product, stock_product: stock_product, has_tag: true, tag: nil)
        second_product = create(:product, stock_product: stock_product, has_tag: true, tag: nil)
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

    it "default current_state" do
      product = build(:product, current_state: nil)
      expect(product).to be_valid
      expect(product.current_state).to eq CurrentState.STOCK
    end

    context "method change_to_in_use validations" do

      it "correct" do
        product = create(:product)
        params = ActionController::Parameters.new( { product: { location: "new_location", open_at: Date.current } }).require(:product).permit(:location, :open_at)
        result = product.change_to_in_use params
        expect(result).to be_truthy
        expect(product.current_state).to eq CurrentState.IN_USE
      end

      it "without location" do
        product = create(:product)
        params = { location: "", open_at: Date.current }
        result = product.change_to_in_use params
        expect(result).to be_falsey
        expect(product.current_state).to eq CurrentState.STOCK
      end

      it "without open_at" do
        product = create(:product)
        params = { location: "some other location", open_at: nil}
        result = product.change_to_in_use params
        expect(result).to be_falsey
        expect(product.current_state).to eq CurrentState.STOCK
      end

    end

end
