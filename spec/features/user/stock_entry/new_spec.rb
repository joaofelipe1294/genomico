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
    click_link id: "stock-dropdown"
    click_link id: "new-stock-entry"
    fill_in "stock_entry[entry_date]", with: Date.current.to_s
    select(stock_product.field.name, from: "fields-select").select_option
    fill_in "stock_entry[product_attributes][lot]", with: "981273kjasbd"
    fill_in "stock_entry[product_attributes][shelf_life]", with: Date.current.to_s
    fill_in "stock_entry[product_attributes][amount]", with: "2"
    fill_in "stock_entry[product_attributes][location]", with: "Some locale"
  end

  def success
    click_button id: "btn-save"
    expect(page).to have_current_path display_new_tag_path(StockEntry.all.sample)
    expect(find(id: "success-warning").text).to eq I18n.t :new_stock_entry_success
  end

  it "complete with label" do
    success
  end

  it "complete without label" do
    choose 'stock_entry[product_attributes][has_tag]', option: "false"
    click_button id: "btn-save"
    expect(page).to have_current_path stock_entries_path
    expect(find(id: "success-warning").text).to eq I18n.t :new_stock_entry_success
  end

  it "without lot" do
    fill_in "stock_entry[product_attributes][lot]", with: ""
    without_value "Lote"
  end

  it "without shelf_life" do
    choose "stock_entry[product_attributes][has_shelf_life]", option: "false"
    success
  end

  it "without amount" do
    fill_in "stock_entry[product_attributes][amount]", with: ""
    without_value "Quantidade"
  end

end
