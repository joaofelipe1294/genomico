require 'rails_helper'

RSpec.describe "releases/show", type: :view do
  before(:each) do
    @release = assign(:release, Release.create!(
      :name => "Name",
      :tag => "Tag",
      :message => "Message",
      :is_actve => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Tag/)
    expect(rendered).to match(/Message/)
    expect(rendered).to match(/false/)
  end
end
