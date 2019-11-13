require 'rails_helper'

RSpec.describe "releases/edit", type: :view do
  before(:each) do
    @release = assign(:release, Release.create!(
      :name => "MyString",
      :tag => "MyString",
      :message => "MyString",
      :is_actve => false
    ))
  end

  it "renders the edit release form" do
    render

    assert_select "form[action=?][method=?]", release_path(@release), "post" do

      assert_select "input[name=?]", "release[name]"

      assert_select "input[name=?]", "release[tag]"

      assert_select "input[name=?]", "release[message]"

      assert_select "input[name=?]", "release[is_actve]"
    end
  end
end
