require 'rails_helper'

RSpec.feature "User::Product::InStocks", type: :feature do
  include UserLogin
  include ValidationChecks

  def generate_stock_entry state
    stock_product = create(:stock_product)
    product = create(:product, stock_product: stock_product, current_state: state)
    stock_entry = create(:stock_entry, product: product)
  end

  def check_count expected
    imunofeno_user_do_login
    visit products_in_stock_path
    expect(find_all(class: "product").size).to eq expected
  end

  it "navigate with login" do
    Rails.application.load_seed
    biomol_user_do_login
    click_link id: "stock-dropdown"
    click_link id: "in-stock-products"
    expect(page).to have_current_path products_in_stock_path
  end

  it "visit without login" do
    visit products_in_stock_path
    wrong_credentials_check
  end

  context "product count validations" do

    before :each do
      Rails.application.load_seed
      create(:user)
      create(:brand)
      generate_stock_entry CurrentState.STOCK
    end

    it "with one product" do
      check_count 1
    end

    it "with in stock and in use product" do
      generate_stock_entry CurrentState.IN_USE
      check_count 1
    end

    it "with many products 3 in stock and 2 in use" do
      generate_stock_entry CurrentState.STOCK
      generate_stock_entry CurrentState.STOCK
      generate_stock_entry CurrentState.IN_USE
      generate_stock_entry CurrentState.IN_USE
      check_count 3
    end

  end


end
