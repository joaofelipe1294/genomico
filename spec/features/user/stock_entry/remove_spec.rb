require 'rails_helper'

RSpec.feature "User::Workflow::StockEntry::Removes", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    create(:brand)
    stock_product = create(:stock_product, name: "Some name")
    @product = build(:product, stock_product: stock_product)
  end

  describe "when user wants to remove a stock entry" do

    before :each do
      create(:stock_entry, product: @product)
    end

    context "when product is in stock" do

      before :each do
        biomol_user_do_login
        visit stock_entries_path
      end

      it "is expected to remove stock entry" do
        expect(find_all(class: "remove-stock-entry").size).to match 1
      end

      it "is expected to remove the stock entry and the product", js: true do
        page.driver.browser.accept_confirm
        click_link class: "remove-stock-entry", match: :first
        expect(page).to have_current_path stock_entries_path
        expect(find(id: "success-warning").text).to eq I18n.t :remove_stock_entry_success
        expect(Product.all.size).to match 0
        expect(StockEntry.all.size).to match 0
      end

    end

    context "when product is in use" do

      it "is expected to not render remove option" do
        @product.change_to_in_use({open_at: Date.current})
        visit stock_entries_path
        expect(find_all(class: "remove-stock-entry").size).to match 0
      end

    end


  end

  describe "when removing a product from a stock_entry" do

    before :each do
      @stock_entry = build(:stock_entry, product: @product)
    end

    context "when stock_entry has one product" do

      it "is expected to don't appar products button" do
        @stock_entry.product_amount = 1
        @stock_entry.save
        biomol_user_do_login
        visit stock_entries_path
        expect(find_all(class: "show-products").size).to match 0
      end

    end

    context "when stock_entry has many products" do

      before :each do
        @stock_entry.product_amount = 51
        @stock_entry.save
        biomol_user_do_login
        visit stock_entries_path
      end

      it "is expected to render show products button" do
        expect(find_all(class: "show-products").size).to match 1
      end

      it "is expected to be able to remove a single product from a stock_entry", js: true do
        click_link class: "show-products", match: :first
        page.driver.browser.accept_confirm
        click_link class: "remove-product", match: :first
        expect(page).to have_current_path stock_entry_path(@stock_entry.reload)
        expect(find(id: "success-warning").text).to match I18n.t :product_destroyed_success
        expect(@stock_entry.reload.products.size).to match 50
      end

    end

  end

end
