require 'rails_helper'
require './app/services/stock_product_amount_manager_service'

describe "StockProductAmountManagerService" do

  before :each do
    Rails.application.load_seed
    create(:brand)
  end

  describe "when a new product is created" do

    context "when current status is is tock" do

      it "is expected to increase stock_product total_aviable" do
        stock_product = create(:stock_product, total_aviable: 0, total_in_use: 0)
        create(:product, stock_product: stock_product, amount: 5, current_state: CurrentState.STOCK)
        expect(stock_product.reload.total_aviable).to match 5
        expect(stock_product.reload.total_in_use).to match 0
      end

      it "is expected to increase stock_product total amount" do
        stock_product = create(:stock_product, total_aviable: 10, total_in_use: 3)
        create(:product, stock_product: stock_product, amount: 3, current_state: CurrentState.STOCK)
        expect(stock_product.reload.total_aviable).to match 13
      end

    end

    context "when current state is in_use" do

      it "is expected to increase only total_in_use" do
        stock_product = create(:stock_product, total_aviable: 0, total_in_use: 0)
        create(:product, stock_product: stock_product, amount: 5, current_state: CurrentState.IN_USE)
        expect(stock_product.reload.total_aviable).to match 0
        expect(stock_product.reload.total_in_use).to match 5
      end

      it "is expected to increase total_in_use" do
        stock_product = create(:stock_product, total_aviable: 10, total_in_use: 3)
        create(:product, stock_product: stock_product, amount: 3, current_state: CurrentState.IN_USE)
        expect(stock_product.reload.total_aviable).to match 10
        expect(stock_product.reload.total_in_use).to match 6
      end

    end

  end

  describe "when a product is moved from stock to in use" do

    it "is expected to increase total_in_use and decrease total_aviable" do
      stock_product = create(:stock_product, total_in_use: 0, total_aviable: 0)
      product = create(:product, stock_product: stock_product, amount: 4, current_state: CurrentState.STOCK)
      expect(stock_product.reload.total_aviable).to match 4
      product.change_to_in_use({ open_at: Date.current })
      expect(stock_product.reload.total_aviable).to match 0
      expect(stock_product.reload.total_in_use).to match 4
    end

  end

  describe "when product is moved from in use to out" do

    it "is expected to decrease total_in_use" do
      stock_product = create(:stock_product, total_in_use: 10, total_aviable: 0)
      product = create(:product, stock_product: stock_product, amount: 5, current_state: CurrentState.IN_USE)
      create(:stock_out, product: product)
      expect(stock_product.reload.total_aviable).to match 0
      expect(stock_product.reload.total_in_use).to match 10
    end

  end

end
