require 'rails_helper'

RSpec.feature "User::StockProduct::News", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    biomol_user_do_login
    click_link id: "stock-dropdown"
    click_link id: "new-stock-product"
    @duplicated = create(:stock_product)
    fill_fields
  end

  def fill_fields
    @stock_product = build(:stock_product)
    fill_in "stock_product[name]", with: @stock_product.name
    fill_in "stock_product[mv_code]", with: @stock_product.mv_code
    select(@stock_product.unit_of_measurement.name, from: "stock_product[unit_of_measurement_id]").select_option
    fill_in "stock_product[usage_per_test]", with: @stock_product.usage_per_test
    fill_in "stock_product[first_warn_at]", with: @stock_product.first_warn_at
    fill_in "stock_product[danger_warn_at]", with: @stock_product.danger_warn_at
  end

  def success_check
    click_button id: "btn-save"
    expect(page).to have_current_path stock_products_path
    expect(find(id: "success-warning").text).to eq I18n.t :new_stock_product_success
  end

  it "navigate" do
    expect(page).to have_current_path new_stock_product_path
  end

  it "complete shared", js: false do
    check "is-shared"
    success_check
  end

  it "complete with field" do
    select(Field.IMUNOFENO.name, from: "stock_product[field_id]").select_option
    success_check
  end

  it "without name" do
    fill_in "stock_product[name]", with: ""
    click_button id: "btn-save"
    expect(find(class: "error", match: :first).text).to eq "Nome não pode ficar em branco"
  end

  it "duplicated name" do
    fill_in "stock_product[name]", with: @duplicated.name
    click_button id: "btn-save"
    expect(find(class: "error", match: :first).text).to eq "Nome já está em uso"
  end

  it "without mv code" do
    fill_in "stock_product[mv_code]", with: ""
    success_check
    other_product_without_mv_code = build(:stock_product, mv_code: "")
    expect(other_product_without_mv_code).to be_valid
  end

  it "duplicated mv" do
    fill_in "stock_product[mv_code]", with: @duplicated.mv_code
    click_button id: "btn-save"
    expect(find(class: "error", match: :first).text).to eq "Código MV já está em uso"
  end

end
