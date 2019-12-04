require 'rails_helper'

RSpec.describe "stock_products/show", type: :view do
  before(:each) do
    @stock_product = assign(:stock_product, StockProduct.create!(
      :name => "Name",
      :usage_per_test => 2,
      :total_aviable => 3,
      :first_warn_at => 4,
      :danger_warn_at => 5,
      :mv_code => "Mv Code",
      :unit_of_measurement => nil,
      :field => nil,
      :is_shared => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Mv Code/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
