require 'rails_helper'

RSpec.feature "User::StockEntry::Indices", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    create(:user)
    create(:brand)
    create(:stock_product)
    product = build(:product)
    create(:stock_entry, product: product)
  end

  def navigate
    imunofeno_user_do_login
    click_link id: "stock-dropdown"
    click_link id: "stock-entries"
  end

  it "Navigate to stock entries" do
    navigate
    expect(page).to have_current_path stock_entries_path
  end

  it "with one stock_entry" do
    navigate
    expect(find_all(class: "stock-entry").size).to eq 1
  end

  it "with three stock_entries" do
    product = build(:product)
    create(:stock_entry, product: product)
    product = build(:product)
    create(:stock_entry, product: product)
    navigate
    expect(find_all(class: "stock-entry").size).to eq 3
  end

end
