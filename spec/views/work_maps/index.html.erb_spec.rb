require 'rails_helper'

RSpec.describe "work_maps/index", type: :view do
  before(:each) do
    assign(:work_maps, [
      WorkMap.create!(),
      WorkMap.create!()
    ])
  end

  it "renders a list of work_maps" do
    render
  end
end
