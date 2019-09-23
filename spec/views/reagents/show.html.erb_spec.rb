require 'rails_helper'

RSpec.describe "reagents/show", type: :view do
  before(:each) do
    @reagent = assign(:reagent, Reagent.create!(
      :product_description => "Product Description",
      :name => "Name",
      :stock_itens => 2,
      :usage_per_test => 3,
      :brand => "Brand",
      :total_aviable => 4,
      :field => nil,
      :first_warn_at => 5,
      :danger_warn_at => 6
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Product Description/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Brand/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(//)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
  end
end
