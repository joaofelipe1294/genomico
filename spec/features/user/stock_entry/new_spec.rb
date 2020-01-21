require 'rails_helper'

RSpec.feature "User::StockEntry::News", type: :feature, js: true do
  include UserLogin
  include ValidationChecks

  before :each do
    Rails.application.load_seed
    create(:user)
    create(:brand)
    stock_product = create(:stock_product)
    biomol_user_do_login
    click_link id: "stock"
    click_link id: "stock-entries-dropdown"
    click_link id: "new-stock-entry"
    fill_in "stock_entry[entry_date]", with: Date.current.to_s
    select(stock_product.field.name, from: "fields-select").select_option
    fill_in "stock_entry[product][lot]", with: "981273kjasbd"
    fill_in "stock_entry[product][shelf_life]", with: Date.current.to_s
    fill_in "stock_entry[product][amount]", with: "2"
    fill_in "stock_entry[product][location]", with: "Some locale"
  end

  def success
    click_button id: "btn-save"
    expect(page).to have_current_path display_new_tag_path(StockEntry.all.sample)
    expect(find(id: "success-warning").text).to eq I18n.t :new_stock_entry_success
  end

  describe "when stock_entry has only one product" do

    context "when product should has a label" do

      it "is expected to display generated label" do
        success
      end

    end

    context "when product shouldn't has a label" do

      it "is expected to be redirected to stock_entries_path" do
        choose 'stock_entry[product][has_tag]', option: "false"
        click_button id: "btn-save"
        expect(page).to have_current_path stock_entries_path
        expect(find(id: "success-warning").text).to eq I18n.t :new_stock_entry_success
      end

    end

  end

  describe "when creating a stock_entry without values" do

    context "when missing value is required" do

      context "when send form without lot" do

        it "is expected to display a message alerting user that lot is missing" do
          fill_in "stock_entry[product][lot]", with: ""
          without_value "Lote"
        end

      end

      context "when send without amount" do

        it "is expected to display message informing that amount is missing" do
          fill_in "stock_entry[product][amount]", with: ""
          without_value "Quantidade"
        end

      end

    end

    context "when missing value is not required" do

      it "is expected to create stock_entry" do
        choose "stock_entry[product][has_shelf_life]", option: "false"
        success
      end

    end

  end

  context "when creating multiple products at same time" do

    context "when product has label" do

      before :each do
        fill_in "stock_entry[product_amount]", with: "15"
        click_button id: "btn-save"
      end

      it "is expected to display all labels after creation" do
        expect(page).to have_current_path display_new_tag_path(StockEntry.all.sample)
        expect(find_all(class: "tag").size).to match 15
      end

      it "is expected to generate multiple products" do
        visit stock_entries_path
        expect(find_all(class: "stock-entry").size).to match 1
      end

    end

    context "when products should not have a label" do

      it "is expectd to be redirected to stock_entries_path" do
        fill_in "stock_entry[product_amount]", with: "52"
        choose 'stock_entry[product][has_tag]', option: "false"
        click_button id: "btn-save"
        visit products_in_stock_path
        expect(Product.count).to match 52
      end

    end

  end

end
