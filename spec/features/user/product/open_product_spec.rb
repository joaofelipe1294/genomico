require 'rails_helper'

RSpec.feature "User::Product::OpenProducts", type: :feature do
  include UserLogin
  include ValidationChecks

  before :each do
    Rails.application.load_seed
    create(:brand)
    create(:stock_product)
    product = create(:product)
    biomol_user_do_login
    visit products_in_stock_path
    expect(find_all(class: "product").size).to eq 1
    click_link class: "open-product", match: :first
    expect(page).to have_current_path new_open_product_path(product)
  end

  it "change status correctly" do
    fill_in "product[open_at]", with: 2.days.ago
    fill_in "product[location]", with: "Some other new location"
    success_check products_in_use_path, :open_product_success
  end

  it "without location" do
    fill_in "product[location]", with: ""
    without_value "Localização"
  end

end
