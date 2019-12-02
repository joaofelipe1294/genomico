require 'rails_helper'

RSpec.feature "User::StockEntry::Navigates", type: :feature do
  include UserLogin

  before(:each) { Rails.application.load_seed }

  it "navigate to stock_entry" do
    biomol_user_do_login
    click_link id: "stock-dropdown"
    click_link id: "stock-entrance"
    expect(page).to have_current_path new_stock_entry_path
  end

  it "access with admin login" do
    admin_do_login
    visit new_stock_entry_path
    expect(page).to have_current_path root_path
  end

  it "without any login" do
    visit new_stock_entry_path
    expect(page).to have_current_path root_path
  end

end
