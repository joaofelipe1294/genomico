require 'rails_helper'

RSpec.describe "hospitals/edit", type: :view do
  before(:each) do
    @hospital = assign(:hospital, Hospital.create!(
      :patient => nil,
      :name => "MyString"
    ))
  end

  it "renders the edit hospital form" do
    render

    assert_select "form[action=?][method=?]", hospital_path(@hospital), "post" do

      assert_select "input#hospital_patient_id[name=?]", "hospital[patient_id]"

      assert_select "input#hospital_name[name=?]", "hospital[name]"
    end
  end
end
