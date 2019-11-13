require 'rails_helper'

RSpec.describe "releases/new", type: :view do
  before(:each) do
    assign(:release, Release.new(
      :name => "MyString",
      :tag => "MyString",
      :message => "MyString",
      :is_actve => false
    ))
  end

  it "renders new release form" do
    render

    assert_select "form[action=?][method=?]", releases_path, "post" do

      assert_select "input[name=?]", "release[name]"

      assert_select "input[name=?]", "release[tag]"

      assert_select "input[name=?]", "release[message]"

      assert_select "input[name=?]", "release[is_actve]"
    end
  end
end
