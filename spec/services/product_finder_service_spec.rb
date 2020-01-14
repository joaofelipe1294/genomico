require 'rails_helper'
require './app/services/product_finder_service'

describe 'status_service' do

  before :each do
    Rails.application.load_seed
    brand = create(:brand)
    stock_product = create(:stock_product)
    @product = create(:product, stock_product: stock_product)
  end

  context "when there is no products in stock" do

    it "is expected to return nil" do
      stock_entry = create(:stock_entry, product: @product)
      service = ProductFinderService.new(@product)
      next_product = service.call
      expect(next_product).to be_nil
    end

  end

  context "when there are products in stock" do

    context "when there is only one product" do

      it "is expected to return it" do
        other_product = create(:product)
        service = ProductFinderService.new(@product)
        next_product = service.call
        expect(next_product).not_to be_nil
        expect(next_product).to match other_product
      end

    end

    context "when there are many itens of the same product" do

      it "is expected to return the one with closest shelf_life" do
        ok_shelf_life_product = create(:product, shelf_life: 2.months.from_now)
        short_shelf_life_product = create(:product, shelf_life: 2.months.ago)
        service = ProductFinderService.new(@product)
        next_product = service.call
        expect(next_product).not_to be_nil
        expect(short_shelf_life_product).to match next_product
      end

    end

  end


end
