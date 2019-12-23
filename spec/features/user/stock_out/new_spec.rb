require 'rails_helper'

RSpec.feature "User::StockOut::News", type: :feature do
  include UserLogin

  it "new stock_out", js: true do
    Rails.application.load_seed
    create(:brand)
    create(:user, user_kind: UserKind.USER)
    stock_product = create(:stock_product)
    product = create(:product, stock_product: stock_product)
    create(:stock_entry, product: product)
    imunofeno_user_do_login
    click_link id: "stock-dropdown"
    click_link id: "in-stock-products"
    click_link class: "open-product", match: :first
    click_button id: "btn-save"
    click_link class: "stock-out", match: :first
    page.driver.browser.switch_to.alert.accept
    click_button id: "btn-save"
    expect(page).to have_current_path stock_outs_path
    expect(find(id: "success-warning").text).to eq I18n.t :new_stock_out_success
    visit products_in_use_path
    expect(find_all(class: "product").size).to eq 0
    click_link id: "stock-dropdown"
    click_link id: "stock-outs"
    expect(page).to have_current_path stock_outs_path
    expect(find_all(class: "stock-out").size).to eq 1
    # sleep 10
  end

end
