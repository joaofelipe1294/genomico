require 'rails_helper'

RSpec.feature "User::StockOut::News", type: :feature do
  include UserLogin

  def do_stock_out_on_first_product
    @product.change_to_in_use({date: Date.current})
    visit new_stock_out_path(@product)
    click_button id: "btn-save"
  end

  before :each do
    Rails.application.load_seed
    create(:user, user_kind: UserKind.USER)
    create(:brand)
    @stock_product = create(:stock_product)
    @product = create(:product, stock_product: @stock_product)
    @stock_entry = create(:stock_entry, product: @product)
  end

  it "new stock_out", js: true do
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
  end

  it "with one product in stock" do
    imunofeno_user_do_login
    second_product = create(:product, stock_product: @stock_product, shelf_life: 2.weeks.from_now)
    create(:stock_entry, product: second_product)
    do_stock_out_on_first_product
    expect(page).to have_current_path next_product_to_open_path(second_product)
  end

  it "without stock_product" do
    imunofeno_user_do_login
    do_stock_out_on_first_product
    expect(find(id: "danger-warning").text).to eq I18n.t :without_product_to_open_in_stock
    expect(page).to have_current_path stock_outs_path
  end

end
