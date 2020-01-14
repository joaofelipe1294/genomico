require 'rails_helper'

RSpec.feature "User::StockProduct::Navigates", type: :feature do
  include UserLogin

  it "navigate with login" do
    Rails.application.load_seed
    biomol_user_do_login
    click_link id: "stock"
    click_link id: "stock-products-dropdown"
    click_link id: "stock-products"
    expect(page).to have_current_path stock_products_path
  end

  it "without login" do
    visit stock_products_path
    expect(page).to have_current_path root_path
  end

end
