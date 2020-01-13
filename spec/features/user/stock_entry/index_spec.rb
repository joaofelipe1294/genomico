require 'rails_helper'

RSpec.feature "User::StockEntry::Indices", type: :feature do
  include UserLogin

  # describe "stock entries index view" do
  #
  #   context "when exist stock entries" do
  #
  #     before :each do
  #       Rails.application.load_seed
  #       create(:user)
  #       create(:brand)
  #       create(:stock_product)
  #       product = build(:product)
  #       create(:stock_entry, product: product)
  #       imunofeno_user_do_login
  #     end
  #
  #     it "Navigate to stock entries" do
  #       click_link id: "stock-dropdown"
  #       click_link id: "stock-entries"
  #       expect(page).to have_current_path stock_entries_path
  #     end
  #
  #     it "with one stock_entry" do
  #       imunofeno_user_do_login
  #       visit stock_entries_path
  #       expect(find_all(class: "stock-entry").size).to eq 1
  #     end
  #
  #     it "with three stock_entries" do
  #       product = build(:product)
  #       create(:stock_entry, product: product)
  #       product = build(:product)
  #       create(:stock_entry, product: product)
  #       visit stock_entries_path
  #       expect(find_all(class: "stock-entry").size).to eq 3
  #     end
  #
  #   end
  #
  #   context "when there is no stock entries" do
  #
  #     it "is expected to render the page without any element" do
  #       Rails.application.load_seed
  #       biomol_user_do_login
  #       visit stock_entries_path
  #       expect(find_all(class: "stock-entry").size).to match 0
  #     end
  #
  #   end
  #
  # end

  describe "when stock entries filter" do

    before :each do
      Rails.application.load_seed
      biomol_user_do_login
      create(:brand)
      @stock_product = create(:stock_product, name: "Some weird name ...")
      first = product = create(:product, stock_product: @stock_product)
      first_stock_entry = create(:stock_entry, product: product)
      second_product = create(:product, stock_product: @stock_product)
      second_stock_entry = create(:stock_entry, product: second_product)
      @second_stock_product = create(:stock_product, name: "Other strange name")
      third_product = create(:product, stock_product: @second_stock_product)
      stock_entry = create(:stock_entry, product: third_product)
    end

    context "when will be results" do

      it "is expected to has results after apply filter" do
        visit stock_entries_path
        expect(find_all(class: "stock-entry").size).to match 3
        select(@stock_product.name, from: "stock_product_id").select_option
        click_button id: "search-by-stock-product"
        expect(find_all(class: "stock-entry").size).to match 2
        select(@second_stock_product.name, from: "stock_product_id").select_option
        click_button id: "search-by-stock-product"
        expect(find_all(class: "stock-entry").size).to match 1
      end

    end

    context "when is suposed to dont return any result" do

      it "is expectd to has no result after filter" do
        other_stock_product = create(:stock_product, name: "Other strange name with no sense ...")
        visit stock_entries_path
        expect(find_all(class: "stock-entry").size).to match 3
        select(other_stock_product.name, from: "stock_product_id").select_option
        click_button id: "search-by-stock-product"
        expect(find_all(class: "stock-product").size).to match 0
      end

    end

  end

end
