require 'rails_helper'

RSpec.describe OfferedExamGroup, type: :model do

  it "complete" do
    offered_exam_group = create(:offered_exam_group, name: 'N.E.R.V')
    expect(offered_exam_group).to be_valid
  end

  it "without name" do
    offered_exam_group = build(:offered_exam_group, name: "")
    expect(offered_exam_group).to be_invalid
  end

  it "dupicated name" do
    duplicated_name = "NERV"
    create(:offered_exam_group, name: duplicated_name)
    duplicated = build(:offered_exam_group, name: duplicated_name)
    expect(duplicated).to be_invalid
  end

  it { should have_many :offered_exams }

end
