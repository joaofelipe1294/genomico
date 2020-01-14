require 'rails_helper'

RSpec.feature "User::StockProduct::Edits", type: :feature do
  include UserLogin
  include ValidationChecks

  before :each do
    Rails.application.load_seed
    create(:stock_product, name: "AAA")
    @duplicated = create(:stock_product, name: "ZZZ")
    biomol_user_do_login
    click_link id: "stock"
    click_link id: "stock-products-dropdown"
    click_link id: "stock-products"
    click_link class: "edit-stock-product", match: :first
  end

  it "navigate to" do
    expect(page).to have_current_path edit_stock_product_path(StockProduct.all.order(:name).first)
  end

  context "correct" do

    after(:each) { success_check stock_products_path, :edit_stock_product_success }

    it "change name" do
      fill_in "stock_product[name]", with: "Some other name"
    end

    it "with mv code" do
      fill_in "stock_product[mv_code]", with: "871623ajsbdjh"
    end

    it "without mv code" do
      fill_in "stock_product[mv_code]", with: ""
    end

    it "shared" do
      check "is-shared"
    end

  end

  context "wrong cases" do

    it "without name" do
      fill_in "stock_product[name]", with: ""
      without_value "Nome"
    end

    it "duplicated_name" do
      fill_in "stock_product[name]", with: @duplicated.name
      duplicated_value "Nome"
    end

    it "duplicated mv" do
      fill_in "stock_product[mv_code]", with: @duplicated.mv_code
      duplicated_value "Código MV"
    end

  end

end
