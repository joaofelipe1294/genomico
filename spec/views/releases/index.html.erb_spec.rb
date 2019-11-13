require 'rails_helper'

RSpec.describe "releases/index", type: :view do
  before(:each) do
    assign(:releases, [
      Release.create!(
        :name => "Name",
        :tag => "Tag",
        :message => "Message",
        :is_actve => false
      ),
      Release.create!(
        :name => "Name",
        :tag => "Tag",
        :message => "Message",
        :is_actve => false
      )
    ])
  end

  it "renders a list of releases" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Tag".to_s, :count => 2
    assert_select "tr>td", :text => "Message".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
