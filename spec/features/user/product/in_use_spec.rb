require 'rails_helper'

RSpec.feature "User::Product::InUses", type: :feature do
  include UserLogin

  it "navigate" do
    Rails.application.load_seed
    create(:brand)
    create(:user)
    create(:stock_product)
    product = create(:product, current_state: CurrentState.IN_USE)
    create(:stock_entry, product: product)
    expect(product.current_state).to eq CurrentState.IN_USE
    imunofeno_user_do_login
    click_link id: "stock-dropdown"
    click_link id: "in-use-product"
    expect(find_all(class: "product").size).to eq 1
  end

  it "put a product in use" do
    Rails.application.load_seed
    create(:brand)
    create(:stock_product)
    product = create(:product)
    create(:stock_entry, product: product)
    biomol_user_do_login
    click_link id: "stock-dropdown"
    click_link id: "in-stock-products"
    expect(page).to have_current_path products_in_stock_path
    click_link class: "open-product", match: :first
    click_button id: "btn-save"
    expect(find_all(class: "product").size).to eq 1
    expect(page).to have_current_path products_in_use_path
  end

end
