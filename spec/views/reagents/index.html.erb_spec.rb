require 'rails_helper'

RSpec.describe "reagents/index", type: :view do
  before(:each) do
    assign(:reagents, [
      Reagent.create!(
        :product_description => "Product Description",
        :name => "Name",
        :stock_itens => 2,
        :usage_per_test => 3,
        :brand => "Brand",
        :total_aviable => 4,
        :field => nil,
        :first_warn_at => 5,
        :danger_warn_at => 6
      ),
      Reagent.create!(
        :product_description => "Product Description",
        :name => "Name",
        :stock_itens => 2,
        :usage_per_test => 3,
        :brand => "Brand",
        :total_aviable => 4,
        :field => nil,
        :first_warn_at => 5,
        :danger_warn_at => 6
      )
    ])
  end

  it "renders a list of reagents" do
    render
    assert_select "tr>td", :text => "Product Description".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Brand".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
