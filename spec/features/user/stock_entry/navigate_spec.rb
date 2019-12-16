require 'rails_helper'

RSpec.feature "User::StockEntry::Navigates", type: :feature do
  include UserLogin
  include ValidationChecks

  it "with login" do
    Rails.application.load_seed
    biomol_user_do_login
    click_link id: "stock-dropdown"
    click_link id: "new-stock-entry"
    expect(page).to have_current_path new_stock_entry_path
  end

  it "without login" do
    visit new_stock_entry_path
    wrong_credentials_check
  end

end
