require 'rails_helper'

RSpec.describe "reagents/new", type: :view do
  before(:each) do
    assign(:reagent, Reagent.new(
      :product_description => "MyString",
      :name => "MyString",
      :stock_itens => 1,
      :usage_per_test => 1,
      :brand => "MyString",
      :total_aviable => 1,
      :field => nil,
      :first_warn_at => 1,
      :danger_warn_at => 1
    ))
  end

  it "renders new reagent form" do
    render

    assert_select "form[action=?][method=?]", reagents_path, "post" do

      assert_select "input[name=?]", "reagent[product_description]"

      assert_select "input[name=?]", "reagent[name]"

      assert_select "input[name=?]", "reagent[stock_itens]"

      assert_select "input[name=?]", "reagent[usage_per_test]"

      assert_select "input[name=?]", "reagent[brand]"

      assert_select "input[name=?]", "reagent[total_aviable]"

      assert_select "input[name=?]", "reagent[field_id]"

      assert_select "input[name=?]", "reagent[first_warn_at]"

      assert_select "input[name=?]", "reagent[danger_warn_at]"
    end
  end
end
