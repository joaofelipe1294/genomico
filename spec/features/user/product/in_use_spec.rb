require 'rails_helper'

RSpec.feature "User::Product::InUses", type: :feature do
  include UserLogin
  include ValidationChecks

  def open_product_and_navigate
    Rails.application.load_seed
    create(:user)
    create(:brand)
    create(:stock_product, field: Field.IMUNOFENO, name: "Azuka Langley")
    product = build(:product)
    create(:stock_entry, product: product)
    biomol_user_do_login
    click_link id: "stock"
    click_link id: "products-dropdown"
    click_link id: "in-stock-products"
    expect(page).to have_current_path products_in_stock_path
    click_link class: "open-product", match: :first
    click_button id: "btn-save"
  end

  it "navigate" do
    Rails.application.load_seed
    create(:brand)
    create(:user)
    create(:stock_product)
    product = build(:product, current_state: CurrentState.IN_USE)
    create(:stock_entry, product: product)
    expect(product.current_state).to eq CurrentState.IN_USE
    imunofeno_user_do_login
    click_link id: "stock"
    click_link id: "in-use-product"
    check_count css: "product", count: 1
  end

  it "put a product in use" do
    open_product_and_navigate
    check_count css: "product", count: 1
    expect(page).to have_current_path products_in_use_path
  end

  it "check name search", js: false do
    open_product_and_navigate
    stock_product = create(:stock_product, is_shared: true, name: "Other name")
    product = build(:product, stock_product: stock_product)
    create(:stock_entry, product: product)
    product.change_to_in_use({open_at: Date.current})
    visit products_in_use_path
    check_count css: "product", count: 2
    fill_in "name", with: "Azuka Lan"
    click_button id: "btn-search-by-name"
    check_count css: "product", count: 1
  end

  it "check field search" do
    open_product_and_navigate
    stock_product = create(:stock_product, is_shared: true, name: "Other name")
    product = build(:product, stock_product: stock_product)
    create(:stock_entry, product: product)
    product.change_to_in_use({open_at: Date.current})
    visit products_in_use_path
    select("Compartilhado", from: "field_id").select_option
    click_button id: "btn-search-by-field"
    check_count css: "product", count: 1
  end

end
