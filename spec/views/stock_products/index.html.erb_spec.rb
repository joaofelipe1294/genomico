require 'rails_helper'

RSpec.describe "stock_products/index", type: :view do
  before(:each) do
    assign(:stock_products, [
      StockProduct.create!(
        :name => "Name",
        :usage_per_test => 2,
        :total_aviable => 3,
        :first_warn_at => 4,
        :danger_warn_at => 5,
        :mv_code => "Mv Code",
        :unit_of_measurement => nil,
        :field => nil,
        :is_shared => false
      ),
      StockProduct.create!(
        :name => "Name",
        :usage_per_test => 2,
        :total_aviable => 3,
        :first_warn_at => 4,
        :danger_warn_at => 5,
        :mv_code => "Mv Code",
        :unit_of_measurement => nil,
        :field => nil,
        :is_shared => false
      )
    ])
  end

  it "renders a list of stock_products" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Mv Code".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
