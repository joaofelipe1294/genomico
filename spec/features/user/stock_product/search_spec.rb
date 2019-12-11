require 'rails_helper'

RSpec.feature "User::StockProduct::Searches", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    imunofeno_user_do_login
  end

  def navigate_to
    click_link id: "stock-dropdown"
    click_link id: "stock-products"
  end

  def generate_3_products
    create(:stock_product, name: "aaa", field: Field.BIOMOL)
    create(:stock_product, name: "abc", field: Field.BIOMOL)
    create(:stock_product, name: "aab", field: nil)
  end

  it "list one example" do
    create(:stock_product)
    navigate_to
    expect(find_all(class: "stock-product").size).to eq 1
  end

  it "list with 3 examples" do
    generate_3_products
    navigate_to
    expect(find_all(class: "stock-product").size).to eq 3
  end

  it "search by name with value" do
    generate_3_products
    navigate_to
    expect(find_all(class: "stock-product").size).to eq 3
    fill_in "name", with: 'aaa'
    click_button id: "btn-search-by-name"
    expect(find_all(class: "stock-product").size).to eq 1
  end

  it "search without value" do
    generate_3_products
    navigate_to
    expect(find_all(class: "stock-product").size).to eq 3
    fill_in "name", with: 'aaa'
    click_button id: "btn-search-by-name"
    expect(find_all(class: "stock-product").size).to eq 1
    fill_in "name", with: ""
    click_button id: "btn-search-by-name"
    expect(find_all(class: "stock-product").size).to eq 3
  end

  it "search by name with wrong value" do
    generate_3_products
    navigate_to
    expect(find_all(class: "stock-product").size).to eq 3
    fill_in "name", with: 'zzz'
    click_button id: "btn-search-by-name"
    expect(find_all(class: "stock-product").size).to eq 0
  end

  it "search_by_field" do
    generate_3_products
    navigate_to
    select(Field.BIOMOL.name, from: "field_id").select_option
    click_button id: "btn-search-by-field"
    expect(find_all(class: "stock-product").size).to eq 2
  end

  it "search_by_field" do
    generate_3_products
    navigate_to
    select("Compartilhado", from: "field_id").select_option
    click_button id: "btn-search-by-field"
    expect(find_all(class: "stock-product").size).to eq 1
  end

end
