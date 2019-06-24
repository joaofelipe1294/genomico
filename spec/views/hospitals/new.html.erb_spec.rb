require 'rails_helper'

RSpec.describe "hospitals/new", type: :view do
  before(:each) do
    assign(:hospital, Hospital.new(
      :patient => nil,
      :name => "MyString"
    ))
  end

  it "renders new hospital form" do
    render

    assert_select "form[action=?][method=?]", hospitals_path, "post" do

      assert_select "input#hospital_patient_id[name=?]", "hospital[patient_id]"

      assert_select "input#hospital_name[name=?]", "hospital[name]"
    end
  end
end
