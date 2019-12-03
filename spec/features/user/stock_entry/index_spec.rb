require 'rails_helper'

RSpec.feature "User::StockEntry::Indices", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    reagent = create(:reagent)
    biomol_user_do_login
  end

  def navigate_to_stock_entrances
    click_link id: "stock-dropdown"
    click_link id: "stock-entrances"
  end

  it "one entry" do
    create(:stock_entry)
    navigate_to_stock_entrances
    expect(find_all(class: "stock-entry").size).to eq 1
  end

  it "zero entrances" do
    navigate_to_stock_entrances
    expect(find_all(class: "stock_entry").size).to eq 0
  end

  it "without shelf date" do
    create(:stock_entry, has_shelf_life: false)
    navigate_to_stock_entrances
    expect(find(class: "shelf-life").text).to eq '-'
  end

  it "with shelf-life" do
    create(:stock_entry, has_shelf_life: true, shelf_life: 2.years.from_now)
    navigate_to_stock_entrances
    expect(find(class: "shelf-life").text).to eq I18n.l(2.years.from_now.to_date)
  end

end
