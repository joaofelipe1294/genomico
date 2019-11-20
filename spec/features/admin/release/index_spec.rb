require 'rails_helper'

RSpec.feature "Admin::Release::Indices", type: :feature do
  include UserLogin

  it "navigate to" do
    Rails.application.load_seed
    create(:release)
    admin_do_login
    click_link id: "release-dropdown"
    click_link id: "releases"
    expect(find_all(class: "release").size).to eq 1
  end

  it "disable release" do
    Rails.application.load_seed
    user = User.create({
      login: "azuka_langley",
      name: "azuka lagley",
      password: "02_unity",
      user_kind: UserKind.USER
      })
    create(:release)
    create(:release, name: "BeTa", tag: "1.0.2")
    admin_do_login
    click_link id: "release-dropdown"
    click_link id: "releases"
    expect(find_all(class: "release").size).to eq 2
    expect(find_all(class: "disable-release").size).to eq 2
    click_link class: "disable-release", match: :first
    expect(find_all(class: "disable-release").size).to eq 1
  end

end
