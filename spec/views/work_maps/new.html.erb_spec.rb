require 'rails_helper'

RSpec.describe "work_maps/new", type: :view do
  before(:each) do
    assign(:work_map, WorkMap.new())
  end

  it "renders new work_map form" do
    render

    assert_select "form[action=?][method=?]", work_maps_path, "post" do
    end
  end
end
