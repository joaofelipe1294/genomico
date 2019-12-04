require 'rails_helper'

RSpec.describe "stock_products/edit", type: :view do
  before(:each) do
    @stock_product = assign(:stock_product, StockProduct.create!(
      :name => "MyString",
      :usage_per_test => 1,
      :total_aviable => 1,
      :first_warn_at => 1,
      :danger_warn_at => 1,
      :mv_code => "MyString",
      :unit_of_measurement => nil,
      :field => nil,
      :is_shared => false
    ))
  end

  it "renders the edit stock_product form" do
    render

    assert_select "form[action=?][method=?]", stock_product_path(@stock_product), "post" do

      assert_select "input[name=?]", "stock_product[name]"

      assert_select "input[name=?]", "stock_product[usage_per_test]"

      assert_select "input[name=?]", "stock_product[total_aviable]"

      assert_select "input[name=?]", "stock_product[first_warn_at]"

      assert_select "input[name=?]", "stock_product[danger_warn_at]"

      assert_select "input[name=?]", "stock_product[mv_code]"

      assert_select "input[name=?]", "stock_product[unit_of_measurement_id]"

      assert_select "input[name=?]", "stock_product[field_id]"

      assert_select "input[name=?]", "stock_product[is_shared]"
    end
  end
end
