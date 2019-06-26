require 'rails_helper'

RSpec.describe "work_maps/edit", type: :view do
  before(:each) do
    @work_map = assign(:work_map, WorkMap.create!())
  end

  it "renders the edit work_map form" do
    render

    assert_select "form[action=?][method=?]", work_map_path(@work_map), "post" do
    end
  end
end
