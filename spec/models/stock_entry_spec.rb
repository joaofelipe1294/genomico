require 'rails_helper'

RSpec.describe StockEntry, type: :model do

  before :each do
    Rails.application.load_seed
    create(:user)
    create(:brand)
    create(:stock_product)
    @product = build(:product)
    @stock_entry = build(:stock_entry, product: @product)
  end

  context "when creating a new stock entry" do

    context "when when missing required vilues" do

      it "is expected to be invalid when entry_date is nil" do
        @stock_entry.entry_date = nil
        expect(@stock_entry).to be_invalid
      end

      it "is expected to be invalid when responsible is nil" do
        @stock_entry.responsible = nil
        expect(@stock_entry).to be_invalid
      end

      it "is expected to be invalid when product_amount is nil" do
        @stock_entry.product_amount = nil
        expect(@stock_entry).to be_invalid
      end

      it "is expected to be invalid when stock_product is nil" do
        @stock_entry.stock_product = nil
        expect(@stock_entry).to be_invalid
      end

    end

    context "stock entry should be invalid when product_amount" do

      it "is equal to zero" do
        @stock_entry.product_amount = 0
        expect(@stock_entry).to be_invalid
      end

      it "is lower than zero" do
        @stock_entry.product_amount = -3
        expect(@stock_entry).to be_invalid
      end

    end

    context "when product is invalid" do

      it "is expected to be invalid when product is nil" do
        @stock_entry.product = nil
        expect(@stock_entry).to be_invalid
      end

      it "is expected to be invalid when a single product attribute is invalid" do
        @product.location = nil
        @stock_entry.product = @product
        expect(@stock_entry).to be_invalid
      end

      it "is expected to be invalid when many product attributes are invalid" do
        @product.location = nil
        @product.brand = nil
        @product.amount = nil
        @stock_entry.product = @product
        expect(@stock_entry).to be_invalid
        expect(@stock_entry.errors.size).to match 3
      end

    end

    context "when genrrating a stock entry with many products" do

      before(:each) { @old_products_count = Product.count }

      it "is expected to generate those products if product is valid" do
        @stock_entry.product_amount = 1
        @stock_entry.save
        new_products_count = Product.count
        expect(new_products_count).to match @old_products_count + 1
        expect(@stock_entry.reload.products.size).to match 1
      end

      it "is expected to create as many products as determined" do
        @stock_entry.product_amount = 50
        @stock_entry.save
        new_products_count = Product.count
        expect(new_products_count).to match @old_products_count + 50
        expect(@stock_entry.reload.products.size).to match 50
      end

      it "is expected to not generate products if it is invalid" do
        @product.location = nil
        @stock_entry.product = @product
        @stock_entry.save
        new_products_count = Product.count
        expect(@old_products_count).to match new_products_count
      end

      it "is expected to remove all products when stock entre is deleted" do
        @stock_entry.product_amount = 10
        @stock_entry.save
        new_products_count = Product.count
        expect(new_products_count).to match @old_products_count + 10
        @stock_entry.destroy
        new_products_count = Product.count
        expect(new_products_count).to match @old_products_count
      end

      it "is expected to treat products in use" do
        old_in_use_products_count = Product.where(current_state: CurrentState.IN_USE).count
        @product.current_state = CurrentState.IN_USE
        @stock_entry.product = @product
        @stock_entry.product_amount = 20
        @stock_entry.save
        new_in_use_products_count = Product.where(current_state: CurrentState.IN_USE).count
        expect(new_in_use_products_count).to match  old_in_use_products_count + 20
      end

    end

    describe "can_remove?" do

      context "when stock_entry has many products" do

        it "and none is in use is expected to return true" do
          @product.current_state = CurrentState.STOCK
          @stock_entry.product_amount = 20
          @stock_entry.save
          expect(@stock_entry.reload.products.size).to match 20
          expect(@stock_entry.can_remove?).to be_truthy
        end

        it "and at least one is in use is expected to return false" do
          @stock_entry.product_amount = 3
          @stock_entry.save
          product = @stock_entry.reload.products.sample
          product.update current_state: CurrentState.IN_USE
          expect(@stock_entry.reload.can_remove?).to be_falsey
        end

      end

      context "when stock_entry has only one product" do

        before :each do
          @stock_entry.product_amount = 1
          @stock_entry.save
          @product = @stock_entry.reload.first_product
        end

        it "is expected to return false if it is in use" do
          @product.update current_state: CurrentState.IN_USE
          expect(@stock_entry.reload.can_remove?).to be_falsey
        end

        it "is expected to return true is product is in stock" do
          @product.update current_state: CurrentState.STOCK
          expect(@stock_entry.reload.can_remove?).to be_truthy
        end

      end

    end

  end

end
