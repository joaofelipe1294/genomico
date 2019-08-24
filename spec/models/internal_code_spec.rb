require 'rails_helper'

RSpec.describe InternalCode, type: :model do

  it "complete" do
    create(:internal_code)
  end

  it "without field" do
    internal_code = build(:internal_code, field: nil)
    expect(internal_code).to be_invalid
  end

  it "without sample" do
    internal_code = build(:internal_code, sample: nil)
    expect(internal_code).to be_invalid
  end

  it "with duplicated code" do
    field = Field.create(name: 'Imunofenotipagem')
    internal_code = create(:internal_code, field: field)
    new_internal_code = create(:internal_code, field: field)
    internal_code.delete
    duplicated = build(:internal_code, field: field)
    expect(duplicated).to be_invalid
  end

  it { should belong_to :field }

  it { should belong_to :sample }

  it { should belong_to :attendance }

  it { should have_many :exams }

end
