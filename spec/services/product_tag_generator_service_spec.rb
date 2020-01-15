require 'rails_helper'

describe 'status_service' do

  context "when generating a new product tag" do

    before :each do
      Rails.application.load_seed
      create(:brand)
    end

    context "when the product is shared" do

      before :each do
        @stock_product = create(:stock_product, is_shared: true)
      end

      after :each do
        service = ProductTagGeneratorService.new(@product)
        generated_tag = service.call
        expect(generated_tag).to match "ALL1"
      end

      it "is expected to generate tag starting with ALL" do
        @product = build(:product, stock_product: @stock_product, has_tag: true)
      end

      it "is expected to follow its own sequence" do
        other_stock_product = create(:stock_product, field: Field.IMUNOFENO, is_shared: false)
        other_product = create(:product, stock_product: other_stock_product)
        @product = build(:product, stock_product: @stock_product, has_tag: true)
        expect(other_product.tag).to match "Imu1"
      end

    end

    context "when product belongs to a area" do

      it "is expected to generate a tag based on its field" do
        stock_product = create(:stock_product, is_shared: false, field: Field.BIOMOL)
        product = build(:product, stock_product: stock_product)
        service = ProductTagGeneratorService.new(product)
        tag = service.call
        expect(tag).to match "Bio1"
      end

      it "is expected to increase field index" do
        first_stock_product = create(:stock_product, is_shared: false, field: Field.IMUNOFENO)
        first_product = create(:product, stock_product: first_stock_product)
        expect(first_product.tag).to match "Imu1"
        second_stock_product = create(:stock_product, is_shared: false, field: Field.IMUNOFENO)
        second_product = build(:product, stock_product: second_stock_product)
        service = ProductTagGeneratorService.new second_product
        tag = service.call
        expect(tag).to match "Imu2"
      end

    end

    context "when product intent to doesn't have a tag" do

      it "is expected to return nil" do
        stock_product = create(:stock_product)
        product = build(:product, has_tag: false)
        service = ProductTagGeneratorService.new product
        tag = service.call
        expect(tag).to be_nil
      end

    end

  end


end






# context "tag generation" do
#
#   before(:each) { setup }
#
#   it "ok" do
#     create(:stock_product, field: Field.BIOMOL)
#     product = create(:product, stock_product: StockProduct.where(field: Field.BIOMOL).first, has_tag: true, tag: nil)
#     expect(product).to be_valid
#     expect(product.tag).to eq "#{Field.BIOMOL.name[0,3]}#{1}"
#   end
#
#   it "without stock_product" do
#     product = build(:product, stock_product: nil)
#     expect(product).to be_invalid
#   end
#
#   it "distinct fields" do
#     create(:stock_product, field: Field.BIOMOL)
#     product_biomol = create(:product, stock_product: StockProduct.where(field: Field.BIOMOL).first, has_tag: true, tag: nil)
#     create(:stock_product, field: Field.IMUNOFENO)
#     product_imunofeno = create(:product, stock_product: StockProduct.where(field: Field.IMUNOFENO).first, has_tag: true, tag: nil)
#     create(:stock_product, field: nil)
#     product_shared = create(:product, stock_product: StockProduct.where(field: nil).first, has_tag: true, tag: nil)
#     expect(product_biomol).to be_valid
#     expect(product_imunofeno).to be_valid
#     expect(product_shared).to be_valid
#     expect(product_biomol.tag).to eq "#{Field.BIOMOL.name[0,3]}#{1}"
#     expect(product_imunofeno.tag).to eq "#{Field.IMUNOFENO.name[0,3]}#{1}"
#     expect(product_shared.tag).to eq "ALL#{1}"
#   end
#
#   it "same area entries" do
#     stock_product = create(:stock_product, field: Field.BIOMOL)
#     first_product = create(:product, stock_product: stock_product, has_tag: true, tag: nil)
#     second_product = create(:product, stock_product: stock_product, has_tag: true, tag: nil)
#     expect(first_product).to be_valid
#     expect(second_product).to be_valid
#     expect(first_product.tag).to eq "#{Field.BIOMOL.name[0, 3]}#{1}"
#     expect(second_product.tag).to eq "#{Field.BIOMOL.name[0, 3]}#{2}"
#   end
#
# end
