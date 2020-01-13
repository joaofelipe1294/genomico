require 'rails_helper'

RSpec.feature "User::Workflow::StockEntry::Removes", type: :feature do
  include UserLogin

  describe "when user wants to remove a stock entry" do

    before :each do
      Rails.application.load_seed
      create(:brand)
      stock_product = create(:stock_product, name: "Some name")
      @product = build(:product, stock_product: stock_product)
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

end
