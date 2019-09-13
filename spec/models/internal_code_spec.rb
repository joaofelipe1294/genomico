require 'rails_helper'

RSpec.describe InternalCode, type: :model do

  before :all do
    Rails.application.load_seed
  end

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
    internal_code = create(:internal_code, field: Field.IMUNOFENO)
    new_internal_code = create(:internal_code, field: Field.IMUNOFENO)
    internal_code.delete
    duplicated = build(:internal_code, field: Field.IMUNOFENO)
    expect(duplicated).to be_invalid
  end

  it { should belong_to :field }

  it { should belong_to :sample }

  it { should belong_to :attendance }

  it { should have_many :exams }

  it { should have_and_belong_to_many :work_maps }

end
