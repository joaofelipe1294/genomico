require 'rails_helper'

RSpec.describe "work_maps/show", type: :view do
  before(:each) do
    @work_map = assign(:work_map, WorkMap.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
